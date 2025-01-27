#!/bin/bash

# Check if the required arguments are provided
if [ "$#" -ne 1 ]; then
  echo "Usage: $0 <number_of_executions>"
  exit 1
fi

# Number of executions
n=$1

# Ensure environment variables are set
if [ -z "$ROOT_URL" ]; then
  echo "Please set ROOT_URL environment variable."
  exit 1
fi

# Timestamp for the log file
start_timestamp=$(date +%Y%m%d_%H%M%S)
log_file="fibo_async_${start_timestamp}.log"

# Execute the loop n times
for ((i=1; i<=n; i++)); do
  {
    exec_number=$(printf "%05d" $i)

    # Execute the curl command
    status_code=$(curl --write-out "%{http_code}" --silent --output /dev/null \
      --location "${ROOT_URL}/observability/fibonacci?n=50" \
      --header "Accept: application/json" \
      --header "x-gateway-apikey: ${API_KEY}" \
      --user "${USER}:${PASSWORD}")
  } &
done

