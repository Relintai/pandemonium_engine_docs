#!/bin/bash

rm -Rf www

mkdir www
cd www
touch .gdignore

cd ..

cd ..
cd ..


for f in *
do
	if [[ "$f" == "_tools"* ]]; then
        	continue
	fi

	echo "copying $f"
	cp -R "$f" "_tools/pdocs/www/"
done