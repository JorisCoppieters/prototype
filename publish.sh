set -e # Bail on first error

npm install -g @angular/cli

DIST=dist-`date +"%Y-%m-%d-%H%M%S"`.zip
DEPLOY=deploy-`date +"%Y-%m-%d-%H%M%S"`.sh

echo "#"
echo "# Zipping distribution & creating scripts"
echo "#"

rm -fr dist
ng build --prod
cd dist
zip -r $DIST ./

cat <<EOF > $DEPLOY
rm -r "/root/websites/prototypeband.co.nz/"*
cd "/root/websites/prototypeband.co.nz"
unzip "/root/downloads/$DIST"
chown -R www-data:www-data .
rm "/root/downloads/$DIST"
rm "/root/downloads/$DEPLOY"
EOF

echo "#"
echo "# Uploading files"
echo "#"

scp $DIST $DEPLOY root@jorisweb.com:downloads/
ssh root@jorisweb.com chmod +x downloads/$DEPLOY

echo "#"
echo "# Executing remote script"
echo "#"

cat $DEPLOY
ssh root@jorisweb.com downloads/$DEPLOY

echo "#"
echo "# Cleaning up"
echo "#"

cd ../
rm -r dist
