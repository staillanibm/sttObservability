#!/bin/bash

# Ensure environment variables are set
if [ -z "$ROOT_URL" ]; then
  echo "Please set ROOT_URL environment variable."
  exit 1
fi

if [ -z "$USER" ]; then
  echo "Please set USER environment variable."
  exit 1
fi

if [ -z "$PASSWORD" ]; then
  echo "Please set USER environment variable."
  exit 1
fi

if [ -z "$PASSWORD" ]; then
  echo "Please set USER environment variable."
  exit 1
fi

if [ -z "$GW_ROOT_URL" ]; then
  echo "Please set GW_ROOT_URL environment variable."
  exit 1
fi

if [ -z "$API_KEY" ]; then
  echo "Please set API_KEY environment variable."
  exit 1
fi

echo "A few simple API calls"
./run-hello.sh 10 Bob
./run-hello.sh 1 error400
./run-hello.sh 2 error500

echo
read -r -p "Press Enter to continue..."
echo

echo "5 services that calculate Fibonacci sequences to saturate CPU"
./run-fibo.sh 5

echo
read -r -p "Press Enter to continue..."
echo

echo "10 services that allocate 100 Mb Heap to saturate RAM"
./run-memory.sh 10

echo
read -r -p "Press Enter to continue..."
echo

echo "50 services that sleep for 60 seconds to saturate threads"
./run-sleep.sh 50 60000

echo
read -r -p "Press Enter to continue..."
echo

echo "Service that produces 1000 messages in a queue"
./run-message.sh 1000 10

echo
read -r -p "Press Enter to continue..."
echo

echo "A few simple API calls, via the API gateway"
./run-hello-gw.sh 5 Bob
./run-hello-gw.sh 3 error400
./run-hello-gw.sh 2 error500

echo
read -r -p "Press Enter to continue..."
echo

echo "A call to analyze Open Telemetry traces"
./run-hello-gw.sh 1 otel