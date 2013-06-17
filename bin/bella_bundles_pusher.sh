#!/bin/bash

bundles_path=/home/gez/Dev/git/bella/vendor/ttps
namespace=TTPS
satis_path=/home/gez/Dev/satis

for dir in `ls -1 ${bundles_path}`
do
    path=${bundles_path}/${dir}
    for bundle in `ls -1 ${path}/TTPS`
    do
        bundle_path=${path}/${namespace}/${bundle}
        cd ${bundle_path}
        echo "* Pushing ${bundle}"
        git push
        echo ""
    done
done

echo "* Rebuilding Satis"
cd ${satis_path}
${satis_path}/bin/build.sh
echo ""

echo "Done!"

