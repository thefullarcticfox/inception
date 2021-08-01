CREATE DATABASE IF NOT EXISTS serverdb;
SET PASSWORD FOR 'mariadb'@'localhost' = PASSWORD('admin42');
CREATE USER IF NOT EXISTS 'mariadb'@'%' IDENTIFIED BY 'admin42';
GRANT ALL PRIVILEGES ON *.* TO 'mariadb'@'localhost';
GRANT ALL PRIVILEGES ON serverdb.* TO 'mariadb'@'%';
FLUSH PRIVILEGES;
