<?php
if (!function_exists('getenv')) {
	function getenv($key) {
		return isset($_ENV[$key]) ? $_ENV[$key] : (isset($_SERVER[$key]) ? $_SERVER[$key] : null);
	}
}
	function getenv1($key) {
		return isset($_ENV[$key]) ? $_ENV[$key] : (isset($_SERVER[$key]) ? $_SERVER[$key] : null);
	}
var_dump(__FILE__, getenv('DEV_MODE'), getenv('BRANCH_NAME'), getenv('TARGET_DIR'), $_ENV, $_SERVER);

echo "Current DEV_MODE = ".getenv('DEV_MODE').". Do you wish to proceed? (Y/N) ";
$input = strtolower(trim(fgets(STDIN)));
if ($input == 'n') {
	exit('Installation aborted.'."\n");
}