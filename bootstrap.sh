# The output of all these installation steps is noisy. With this utility
# the progress report is nice and concise.
function install {
    echo installing $1
    shift
    apt-get -y install "$@" >/dev/null 2>&1
}

echo adding swap file
fallocate -l 2G /swapfile
chmod 600 /swapfile
mkswap /swapfile
swapon /swapfile
echo '/swapfile none swap defaults 0 0' >> /etc/fstab

echo updating package information
apt-add-repository -y ppa:brightbox/ruby-ng >/dev/null 2>&1
apt-get -y update >/dev/null 2>&1

install 'development tools' build-essential

#install Ruby ruby2.3 ruby2.3-dev
#update-alternatives --set ruby /usr/bin/ruby2.3 >/dev/null 2>&1
#update-alternatives --set gem /usr/bin/gem2.3 >/dev/null 2>&1

#echo installing Bundler
#gem install bundler -N >/dev/null 2>&1

install Git git
install curl curl

echo Installing RVM

#git clone https://github.com/rbenv/rbenv.git ~/.rbenv
#echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
#~/.rbenv/bin/rbenv init
#rbenv install 1.9.3-p448

gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3

\curl -sSL https://get.rvm.io | bash -s stable --ruby=1.9.3-p448

#install SQLite sqlite3 libsqlite3-dev
#install memcached memcached
#install Redis redis-server
#install RabbitMQ rabbitmq-server

#install PostgreSQL postgresql postgresql-contrib libpq-dev
#sudo -u postgres createuser --superuser vagrant
#sudo -u postgres createdb -O vagrant activerecord_unittest
#sudo -u postgres createdb -O vagrant activerecord_unittest2

debconf-set-selections <<< 'mysql-server mysql-server/root_password password root'
debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password root'
install MySQL mysql-server libmysqlclient-dev
mysql -uroot -proot <<SQL
CREATE USER 'rails'@'localhost';
CREATE DATABASE activerecord_unittest  DEFAULT CHARACTER SET utf8 DEFAULT COLLATE utf8_general_ci;
CREATE DATABASE activerecord_unittest2 DEFAULT CHARACTER SET utf8 DEFAULT COLLATE utf8_general_ci;
GRANT ALL PRIVILEGES ON activerecord_unittest.* to 'rails'@'localhost';
GRANT ALL PRIVILEGES ON activerecord_unittest2.* to 'rails'@'localhost';
GRANT ALL PRIVILEGES ON inexistent_activerecord_unittest.* to 'rails'@'localhost';
SQL

install 'Nokogiri dependencies' libxml2 libxml2-dev libxslt1-dev
install 'ExecJS runtime' nodejs
install xclip xclip

# Needed for docs generation.
update-locale LANG=en_US.UTF-8 LANGUAGE=en_US.UTF-8 LC_ALL=en_US.UTF-8

echo Installing SUMMON 
echo User: $1

mkdir /home/summon
cd /home/summon

git clone https://$1:$2@github.com/summon/CustomizeR.git
git clone https://$1:$2@github.com/summon/maverick.git
git clone https://$1:$2@github.com/summon/summon-api.git

echo Next steps: 
echo '1. type "vagrant ssh" to access the VM, all summon dirs should be there.'
echo '2. You need to create a public ssh and associate it to your github account.'
echo '   Instructions:   https://help.github.com/articles/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent/'
echo '   To copy the key just run: cat ~/.ssh/id_rsa.pub    And copy the pass from your cmd console.'
echo '3. cd maveric  ->  bundle install'

echo 
echo 'all set, rock on!'
