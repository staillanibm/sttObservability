#!/bin/bash

# Check if the required arguments are provided
if [ "$#" -ne 2 ]; then
  echo "Usage: $0 <number_of_executions> <order>"
  exit 1
fi

# Number of executions
n=$1
order=$2

# Ensure environment variables are set
if [ -z "$ROOT_URL" ]; then
  echo "Please set ROOT_URL environment variable."
  exit 1
fi

# Execute the loop n times
for ((i=1; i<=n; i++)); do
  {
    exec_number=$(printf "%05d" $i)

    # Execute the curl command
    status_code=$(curl --write-out "%{http_code}" --silent --output /dev/null \
      --location "${ROOT_URL}/observability/fibonacci?n=${order}" \
      --header "Accept: application/json" \
      --user "${USER}:${PASSWORD}")
  } &
done

