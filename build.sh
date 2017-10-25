#!/bin/bash
BUNDLE_PATH="/srv/chat"
METEOR_ALLOW_SUPERUSER=1

# Create BUNDLE_PATH directory if it does not exist
[ ! -d $BUNDLE_PATH ] && mkdir -p $BUNDLE_PATH || :

if [ -d "$BUNDLE_PATH" ]; then
	echo "=> Updating..."; echo;
	git clean -df
	git checkout -- .
	git checkout steedos
	git pull

	echo "=> Npm install..."; echo;
	meteor npm install -d

	# on the very first build, meteor build command should fail due to a bug on emojione package (related to phantomjs installation)
	# the command below forces the error to happen before build command (not needed on subsequent builds)
	set +e
	meteor add rocketchat:lib
	set -e

	echo "=> Building bundle..."; echo;
	meteor build --server-only --server https://cn.steedos.com/chat --directory $BUNDLE_PATH --allow-superuser
	cd $BUNDLE_PATH/bundle/programs/server
	# rm -rf node_modules
	# rm -f npm-shrinkwrap.json
	npm install -d

	echo "=> Strat server..."; echo;
	cd $BUNDLE_PATH
	pm2 restart chat.0

else
	echo "!!!=> Failed to create bundle path: $BUNDLE_PATH"
fi