<?php
define('DB_NAME', '{{wordpress.db_name}}');
define('DB_USER', '{{wordpress.db_user}}');
define('DB_PASSWORD', '{{wordpress.db_password}}');
define('DB_HOST', '{{wordpress.db_host}}');
define('DB_CHARSET', 'utf8');
define('DB_COLLATE', '');
define('AUTH_KEY',         '{{wordpress.auth_string}}');
define('SECURE_AUTH_KEY',  '{{wordpress.auth_string}}');
define('LOGGED_IN_KEY',    '{{wordpress.auth_string}}');
define('NONCE_KEY',        '{{wordpress.auth_string}}');
define('AUTH_SALT',        '{{wordpress.auth_string}}');
define('SECURE_AUTH_SALT', '{{wordpress.auth_string}}');
define('LOGGED_IN_SALT',   '{{wordpress.auth_string}}');
define('NONCE_SALT',       '{{wordpress.auth_string}}');
$table_prefix  = 'wp_';
define('DISALLOW_FILE_MODS', true);
define('AUTOMATIC_UPDATER_DISABLED', true);
define('WP_DEBUG', false);
if ( !defined('ABSPATH') )
        define('ABSPATH', '/usr/share/wordpress');
require_once(ABSPATH . 'wp-settings.php');
