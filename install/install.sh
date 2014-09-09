#!/bin/bash


# set environmental variables that we will need in child script/processes
#export DEV_MODE=$1

# by default run install
DEPLOY_ACTION=${1:-install}

#DIR=$( cd "$( dirname "$0" )" && pwd )
echo "deploy action = $DEPLOY_ACTION and DEV_MODE = $DEV_MODE and TARGET_DIR = $TARGET_DIR"
echo "pwd = $( pwd ) "

# must change the current directory for git to work on
cd "$TARGET_DIR"

# current remote name
remote_name=$(git remote show);
# current branch name
#branch_name=$(git rev-parse --abbrev-ref HEAD);
#current repo URL
repo_url=$(git ls-remote --get-url $remote_name);

echo "pwd = $( pwd ) remote_name = $remote_name and repo_url = $repo_url"
echo $(pidof -x monitor_dropbox.sh);
exit;

if [ "$DEPLOY_ACTION" = "install" ] 
then
	# on repo clone we must execute the PHP install manually
	php install/install.php "$DEV_MODE" "$DEPLOY_ACTION"
	# echo 'Starting monitoring scripts'
	# this will start the monitoring scripts, but admin still needs to update crontab!!
	# sh cron1.sh > /dev/null 2>&1
else 
	echo "Pulling from $remote_name/$BRANCH_NAME"
	# should I use origin or $remote_name here??? git pull -s recursive -X theirs "$remote_name"/"$branch_name"
	git pull -s recursive -X theirs "$remote_name"/"$BRANCH_NAME"
	# if config or monitoring scripts/templates were changed run installation update 
	changed_files="$(git diff-tree -r --name-only --no-commit-id ORIG_HEAD HEAD)"
	echo "$changed_files" | grep 'config\.php\|\.sh\.tpl' && { 
		php install/install.php "$DEV_MODE" "$DEPLOY_ACTION"
		# on config change we have to update monitoring scripts, so kill them!!!
		# kill -9 $(pidof -x monitor_dropbox.sh)
		# kill -9 $(pidof -x monitor_in2.sh)
		# kill -9 $(pidof -x outfolder_monitor.sh)
	}
fi
