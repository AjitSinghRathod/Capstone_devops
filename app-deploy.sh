#! /bin/bash

mongourl="mongodb+srv://testajit8:hvkh1TxAbcmVTYAX@cluster0.hogrvzx.mongodb.net/test"
jwtkey="QQKwWjcoGQ1NCsDHa5dP5jSG5L+mDto/z59QZwmFkKRtFeWKvBCPa2L1qGYKvpsN91AbaDRmbmDrLxrrBAs2VHmz6HTlsVDV01UyS6hPzfQAOf9/EtG51I0lVCvEloIKyhGwFl2m0ESLUvFbUUguOXixp+I0U8yAc5riEot1o/xyL17rTdsFqtgGibD5J7mOrys5ayciUxf7MoTLyq4rMDpAiz9NLPDN5yQ=="

removedockercontainer(){
docker stop $( docker ps -a | grep app | awk '{print $1}')
docker rm $( docker ps -a | grep app | awk '{print $1}')
}

removedockerimages(){
docker rmi $( docker images | grep -Ew "frontend" | awk '{print $3}') --force
docker rmi $( docker images | grep -Ew "backend" | awk '{print $3}') --force
}

deploy_app(){
ip=`hostname -I | awk '{print $1}'`
echo $ip

MONGO_URL="$mongourl"

JWT_SECRET_KEY="$jwtkey"


cd ResumeBuilderBackend
echo "JWT_SECRET_KEY=$jwtkey 
MONGO_URL=$mongourl" > .env

cat .env	
 
#docker build -t resume_builder:backend . --no-cache
#docker run -itd --name backend_app  -p 4292:4292 resume_builder:backend

cd ../ResumeBuilderAngular/

sed -i 's#\("target":\).*#\1 "'"http://${ip}:4292"'",#g' proxy.conf.json

#docker build -t resume_builder:frontend . --no-cache
#docker run -itd  --name frontend_app  -p 4200:4200 resume_builder:frontend

}
removedockercontainer
removedockerimages
deploy_app


