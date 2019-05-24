#!/bin/bash

set -e # Bail on first error

#npm install -g @angular/cli

DIST_ZIP=dist-`date +"%Y-%m-%d-%H%M%S"`.zip
DEPLOY_SCRIPT=deploy-`date +"%Y-%m-%d-%H%M%S"`.sh
BACKUP_DATE=`date +"%Y-%m-%d-%H%M%S"`
SITENAME="prototypeband.co.nz"

echo "#"
echo "# Formatting files"
echo "#"

npm run format

echo "#"
echo "# Creating distribution"
echo "#"

rm -fr dist
ng build --prod

echo "#"
echo "# Zipping distribution & creating scripts"
echo "#"

cd dist
zip -r $DIST_ZIP ./

echo "" > $DEPLOY_SCRIPT
echo "mv \"/home/ubuntu/sites/"$SITENAME"/\" \"/home/ubuntu/sites_backup/"$BACKUP_DATE"_"$SITENAME"\"" >> $DEPLOY_SCRIPT
echo "mkdir \"/home/ubuntu/sites/"$SITENAME"\"" >> $DEPLOY_SCRIPT
echo "cd \"/home/ubuntu/sites/"$SITENAME"\"" >> $DEPLOY_SCRIPT
echo "unzip \"/home/ubuntu/downloads/$DIST_ZIP\"" >> $DEPLOY_SCRIPT
echo "sudo chown -R www-data:www-data ." >> $DEPLOY_SCRIPT
echo "sudo chown www-data:ubuntu ." >> $DEPLOY_SCRIPT
echo "rm \"/home/ubuntu/downloads/$DIST_ZIP\"" >> $DEPLOY_SCRIPT
echo "rm \"/home/ubuntu/downloads/$DEPLOY_SCRIPT\"" >> $DEPLOY_SCRIPT

echo "#"
echo "# Uploading files"
echo "#"

scp $DIST_ZIP $DEPLOY_SCRIPT jorisweb.com:downloads/
ssh jorisweb.com chmod +x downloads/$DEPLOY_SCRIPT

echo "#"
echo "# Executing remote script"
echo "#"

cat $DEPLOY_SCRIPT
ssh jorisweb.com downloads/$DEPLOY_SCRIPT

echo "#"
echo "# Cleaning up"
echo "#"

cd ../
rm -r dist
