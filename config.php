<?php

error_reporting(1);
ini_set('display_errors', 1);

include_once './inc/functions_general.php';
include_once './inc/class_database.php';
include_once './inc/class_he_database.php';
include_once './inc/class_view.php';
include_once './inc/class_champ.php';
include_once './inc/class_team_champ.php';

date_default_timezone_set('Asia/Bishkek');

$database_host = 'localhost';
$database_username = 'root';
$database_password = '1234';
$database_name = 'football';


$database =& SEDatabase::getInstance();
$database->database_set_charset('utf8');

if (isset($_REQUEST['admin'])) { setcookie('admin', $_REQUEST['admin'], strtotime('+1 year')); }
$is_admin = isset($_COOKIE['admin']) ? (md5($_COOKIE['admin']) == '63a9f0ea7bb98050796b649e85481845') : false;

$view = new view();