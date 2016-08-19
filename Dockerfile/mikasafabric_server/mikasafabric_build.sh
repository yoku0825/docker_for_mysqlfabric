#!/bin/bash

dirname="mikasafabric-0.0.13"
rm -rf ~/rpmbuild
mkdir -p ~/rpmbuild/{BUILD,RPMS,SOURCES,SPECS,SRPMS}

if [ -d ~/$dirname ] ; then
  rm -rf ~/$dirname
fi
git clone https://github.com/gmo-media/mikasafabric.git ~/$dirname
cd ~/$dirname
git checkout master
cd $OLDPWD

zip -r ~/rpmbuild/SOURCES/${dirname}.zip $dirname
rpmbuild -bb ~/$dirname/mikasafabric.spec
