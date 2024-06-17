#!/bin/bash

CONTAINER_IMAGE="stremio/server"

CONTAINER_CMD="sudo docker run --rm -d -p 11470:11470 -p 12470:12470 -e NO_CORS=1 $CONTAINER_IMAGE"


start_container() {
	if [ "$(sudo docker ps -q --filter ancestor="$CONTAINER_IMAGE" --format="{{.Image}}" )" ]; then
		echo "Container: $CONTAINER_IMAGE is already running..."
		return 0
	fi

	echo "Starting $CONTAINER_NAME...."
	$CONTAINER_CMD
	sleep 1

	if [ "$(sudo docker ps -q --filter ancestor="$CONTAINER_IMAGE" --format="{{.Image}}" )" ]; then
		echo "Container: $CONTAINER_IMAGE, has started succesfully!"
	else
		echo "Container failed start."
		return 1
	fi
}

stop_container() {
	if [ "$(sudo docker ps -q --filter ancestor="$CONTAINER_IMAGE" --format="{{.Image}}" )" ]; then
		echo "Stopping Container: $CONTAINER_IMAGE"
		sudo docker stop $(sudo docker ps -q --filter ancestor="$CONTAINER_IMAGE")
		sleep 1
		echo "Container: $CONTAINER_IMAGE, stopped."
	else
		echo "Container: $CONTAINER_IMAGE, is not running...."
	fi
}

case "$1" in
    start)
        start_container
        ;;
    stop)
        stop_container
        ;;
    *)
        echo "Usage: $0 [start|stop]"
        exit 1
        ;;
esac
 



