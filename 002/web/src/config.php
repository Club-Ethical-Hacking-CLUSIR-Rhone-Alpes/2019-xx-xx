<?php

ini_set('display_errors', false);
error_reporting(null);
session_start();

$SITE_NAME = 'pvex';
$PUB_DIR = 'pub/';
$ADMIN_DIR = 'admin/';


$DB_CONN = new PDO('mysql:host=172.16.2.102;port=3306;dbname=pvex;', 'pvex_dbuser', '10UjtJWyoYORw');





