<?php
if (!function_exists('getenv')) {
	function getenv($key) {
		return isset($_ENV[$key]) ? $_ENV[$key] : (isset($_SERVER[$key]) ? $_SERVER[$key] : null);
	}
}
	function getenv1($key) {
		return isset($_ENV[$key]) ? $_ENV[$key] : (isset($_SERVER[$key]) ? $_SERVER[$key] : null);
	}
var_dump(__FILE__, getenv('DEV_MODE'), getenv('BRANCH_NAME'), $_SERVER);