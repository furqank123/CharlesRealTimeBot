#!/bin/bash

APP=$1
PLATFORM=$2
DIRECTORY=CharlesSession

echo "$APP"
echo "$PLATFORM"

if [ -d "$DIRECTORY" ] 
then
	cd $DIRECTORY 
	git pull
	cd ..
else 
	git clone https://github.com/furqank123/CharlesSession.git 
fi

if [ $APP == "ESPN" ] && [ $PLATFORM == "Android" ] || [ $PLATFORM == "iOS" ] 
then 
	gradle -p CharlesSession/RunSession/ clean build --parallel & 
	curl -v -x http://192.168.86.59:8888 http://control.charles/recording/start &
	sleep 180 
	curl -o session.chls -x http://192.168.86.59:8888 http://control.charles/session/download &
	curl -v -x http://192.168.86.59:8888 http://control.charles/recording/stop &
	Charles convert session.chls session.chlsj


	elif [ $APP == "Twitch" ] && [ $PLATFORM == "Android" ] || [ $PLATFORM == "iOS" ] 
	then
		echo "Do nothing"

	elif [ $APP == "Netflix" ] && [ $PLATFORM == "Android" ] || [ $PLATFORM == "iOS" ]
	then
		echo "Do nothing"
fi

