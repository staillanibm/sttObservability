#!/bin/bash

# Check if the required arguments are provided
if [ "$#" -ne 2 ]; then
  echo "Usage: $0 <number_of_executions> <name>"
  exit 1
fi

# Number of executions
n=$1

# Name
NAME=$2

# Ensure environment variables are set
if [ -z "$GW_ROOT_URL" ]; then
  echo "Please set GW_ROOT_URL environment variable."
  exit 1
fi

if [ -z "$API_KEY" ]; then
  echo "Please set API_KEY environment variable."
  exit 1
fi

# Execute the loop n times
for ((i=1; i<=n; i++)); do
    status_code=$(curl --write-out "%{http_code}" --silent --output /dev/null \
      --location "${GW_ROOT_URL}/gateway/ObservabilityAPI/1.0/hello?name=${NAME}" \
      --header "Accept: application/json" \
      --header "x-gateway-apikey: ${API_KEY}")
    echo "Call ${i} - Status code: ${status_code}"
done

