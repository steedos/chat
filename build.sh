#!/bin/bash
BUNDLE_PATH="/srv/chat"

# Create BUNDLE_PATH directory if it does not exist
[ ! -d $BUNDLE_PATH ] && mkdir -p $BUNDLE_PATH || :

if [ -d "$BUNDLE_PATH" ]; then
	echo "=> Updating..."; echo;
	git clean -df
	git checkout -- .
	git checkout steedos
	git pull

	echo "=> Npm install..."; echo;
	npm config set registry https://registry.npm.taobao.org
	cd packages/rocketchat-katex
	npm install -d
	cd ../rocketchat-livechat/app
	npm install bcrypt -d
	npm install -d
	cd ../../../
	npm install -d

	echo "=> Building bundle..."; echo;
	meteor build --server https://cn.steedos.com/chat --directory $BUNDLE_PATH --allow-superuser
	cd $BUNDLE_PATH/bundle/programs/server
	rm -rf node_modules
	rm -f npm-shrinkwrap.json
	npm install --registry https://registry.npm.taobao.org -d

	echo "=> Strat server..."; echo;
	cd $BUNDLE_PATH
	pm2 restart chat.0

else
	echo "!!!=> Failed to create bundle path: $BUNDLE_PATH"
fi