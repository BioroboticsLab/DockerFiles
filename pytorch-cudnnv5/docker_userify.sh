#! /usr/bin/env bash

if [ "$1" == "--help" ]; then
    echo "$0 generate user for the docker file"
    echo "    -u | --user NAME          name of the user. default: current user"
    echo "    --uid UID                 uid of the user. default: uid of current user"
    echo "    -p | --password PASSWORD  password of the user. default: username"
    exit 0
fi

while [[ $# -gt 1 ]]
do
key="$1"

case $key in
    -u|--user)
    USER="$2"
    shift # past argument
    ;;
    --uid)
    UID="$2"
    shift # past argument
    ;;
    -p|--password)
    PASSWORD="$2"
    shift # past argument
    ;;
    *)
            # unknown option
    ;;
esac
shift # past argument or value
done

echo $USER
echo $UID
echo $PASSWORD
if [ "$PASSWORD" == "" ]; then
    PASSWORD="$USER"
fi


OUT_DIR="docker-$USER"
mkdir -p  "$OUT_DIR"
export USER UID PASSWORD
envsubst < Dockerfile > $OUT_DIR/Dockerfile
