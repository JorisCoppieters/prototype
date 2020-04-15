#!/bin/bash

set -e # Bail on first error

CURRENT_DATE_STAMP=`date +"%Y-%m-%d-%H%M%S"`
HOST="karaokesonglookup.com"
SERVER_ADMIN="joris.coppieters@gmail.com"
DIST_ZIP="dist-$HOST-$CURRENT_DATE_STAMP.zip"
REMOTE_SCRIPT="deploy-$HOST-$CURRENT_DATE_STAMP.sh"

function replace_vars () {
  if [[ $# -lt 1 ]]; then
    echo "Usage $0: [FILE]";
    return;
  fi
  FILE=$1
  sed -i '
    s/<HOST>/'$HOST'/g;
    s/<CURRENT_DATE_STAMP>/'$CURRENT_DATE_STAMP'/g;
    s/<SERVER_ADMIN>/'$SERVER_ADMIN'/g;
    s/<DIST_ZIP>/'$DIST_ZIP'/g;
    s/<REMOTE_SCRIPT>/'$REMOTE_SCRIPT'/g;
  ' $FILE
}

echo ""
echo "#"
echo "# Formatting files"
echo "#"
echo ""

npm run format

echo ""
echo "#"
echo "# Creating distribution"
echo "#"
echo ""

rm -fr dist
ng build --prod

cp ./build/scripts/apache2/http.conf dist/http.conf
replace_vars dist/http.conf

cp ./build/scripts/apache2/https.conf dist/https.conf
replace_vars dist/https.conf

echo ""
echo "#"
echo "# Zipping distribution & creating scripts"
echo "#"
echo ""

cd dist
zip -r $DIST_ZIP ./

cp -r ../build/scripts/publish-remote.sh $REMOTE_SCRIPT
replace_vars $REMOTE_SCRIPT
chmod +x $REMOTE_SCRIPT

echo ""
echo "#"
echo "# Executing remote script"
echo "#"
echo ""

scp $DIST_ZIP $REMOTE_SCRIPT jorisweb.com:downloads/
ssh jorisweb.com chmod +x downloads/$REMOTE_SCRIPT

cat $REMOTE_SCRIPT
ssh jorisweb.com downloads/$REMOTE_SCRIPT

echo ""
echo "#"
echo "# Cleaning up"
echo "#"
echo ""

cd ../
rm -r dist
