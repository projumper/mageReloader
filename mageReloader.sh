#!bash

rm -rf /var/www/share/XXX/htdocs/pub/static/*
rm -rf /var/www/share/XXX/htdocs/var/composer_home/*
rm -rf /var/www/share/XXX/htdocs/var/generation/*
rm -rf /var/www/share/XXX/htdocs/generated/code/*
rm -rf /var/www/share/XXX/htdocs/var/page_cache/*
rm -rf /var/www/share/XXX/htdocs/var/view_preprocessed/*

cd /var/www/share/xxx/htdocs

#git pull origin master

#composer install

php bin/magento maintenance:enable

echo "should i upgrade and compile?"
select yn in "Yes" "No": do

 case $yn in
        Yes ) php bin/magento setup:upgrade && php bin/magento setup:di:compile;;
        No ) exit;;
    esac
done



php bin/magento setup:static-content:deploy de_DE
php bin/magento setup:static-content:deploy en_US
#php bin/magento setup:static-content:deploy en_GB
php bin/magento indexer:reindex; php bin/magento c:c; php bin/magento c:f;
php bin/magento maintenance:disable

