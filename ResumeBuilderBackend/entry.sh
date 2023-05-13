#! /bin/bash

echo "JWT_SECRET_KEY=$jwtkey 
 MONGO_URL=$mongodburl" > .env

export JWT_SECRET_KEY=$jwtkey
export MONGO_URL=$mongodburl

npm start
