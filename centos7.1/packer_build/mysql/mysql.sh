CURDIR=$(cd $(dirname $0); pwd)

wget http://dev.mysql.com/get/mysql-community-release-el7-5.noarch.rpm
rpm -Uvh mysql-community-release-el7-5.noarch.rpm
yum -y install mysql-community-server

mysql mysql_install_db

systemctl enable mysqld.service
systemctl start mysqld.service

/usr/bin/mysqladmin -u root password $MYSQL_ROOT_PASSWORD

# create db
sed -f $BASEDIR/sed_createdb.lst $CURDIR/conf/createdb.sql.tmpl > $CURDIR/conf/createdb.sql
sudo mysql -uroot -p$MYSQL_ROOT_PASSWORD < $CURDIR/conf/createdb.sql

systemctl disable mysqld.service