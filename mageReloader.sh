#!bash

rm -rf /var/www/share/XXX/htdocs/pub/static/*
rm -rf /var/www/share/XXX/htdocs/var/composer_home/*
rm -rf /var/www/share/XXX/htdocs/var/generation/*
rm -rf /var/www/share/XXX/htdocs/generated/code/*
rm -rf /var/www/share/XXX/htdocs/var/page_cache/*
rm -rf /var/www/share/XXX/htdocs/var/view_preprocessed/*

cd /var/www/share/svbdev.zw-server.de/htdocs

#git pull origin master

#composer install


echo "enabling maintenance mode"
#php bin/magento maintenance:enable


read -p "should i upgrade and compile? (y/n)? " answer

 case $answer in
        y|Yes|Y ) php bin/magento setup:upgrade && php bin/magento setup:di:compile
        ;;
        *) echo "skiping"
        ;;
 esac


read -p "should i deploy de_DE content? (y/n)? " answer

 case $answer in
        y|Yes|Y ) php bin/magento setup:static-content:deploy de_DE
        ;;
        *) echo "skiping"
        ;;
 esac


read -p "should i flush cache and reindex ? (y/n)? " answer

 case $answer in
        y|Yes|Y ) php bin/magento indexer:reindex; php bin/magento c:c; php bin/magento c:f
        ;;
        *) echo "skiping"
        ;;
 esac


#php bin/magento setup:static-content:deploy en_US
#php bin/magento setup:static-content:deploy en_GB

echo "diasable maintenance mode"
php bin/magento maintenance:disable

