#!/bin/bash

# Default HOST:PORT tragetted
HOST="localhost"
PORT=1337
ID=1

function usage {
    echo "Usage: simulator.sh [-h HOST] [-p PORT] [-i ID]"
    exit 1
}

# Parse arguments
while getopts h:p:i: FLAG; do
  case $FLAG in
    h)
      HOST=$OPTARG
      ;;
    p)
      PORT=$OPTARG
      ;;
    i)
      ID=$OPTARG
      ;;
    \?)
      usage
      ;;
  esac
done

echo "=> About to send data to $HOST on port $PORT"
echo

# Generate and send random data
while(true); do
    # Current date
    d=$(date -u +"%Y-%m-%dT%H:%M:%SZ")

    # Random temperature between 20 and 34°C
    temp1=$(( ( RANDOM % 15 )  + 20 ))
    
    # Send data to API
    curl -XPOST -H "Content-Type: application/json" -d '{"ts":"'$d'", "type": "temp", "value": '$temp1', "sensor_id": '$ID' }' http://$HOST:$PORT/data
    sleep 1

    
done
