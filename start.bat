call meteor npm i --registry https://registry.npm.taobao.org -d

set NODE_OPTIONS=--max-old-space-size=2047
set TOOL_NODE_FLAGS=--max-old-space-size=2047

set DB_SERVER=192.168.0.21
set MONGO_URL=mongodb://%DB_SERVER%/steedos
set MONGO_OPLOG_URL=mongodb://%DB_SERVER%/local
set MULTIPLE_INSTANCES_COLLECTION_NAME=chat_instances
set ROOT_URL=http://192.168.0.88:3000/
meteor run 