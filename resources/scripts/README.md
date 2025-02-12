# Observability helper scripts

This folder contains several scripts to demo the management of Prometheus metrics in webmethods products. These scripts point to an Observability API, exposed by the package associated to this Git repository. 

##  Pre-requisites

The sttObservability package must be deployed into an IS or MSR.  
The following environment variables must be set before running any script:
-   ROOT_URL: the URL of the IS/MSR. For instance "http://localhost:5555"
-   USER: basic auth user to call the IS/MSR. For instance "Administrator"
-   PASSWORD: basic auth password to call the IS/MSR. For instance "manage"

```
export ROOT_URL=http://localhost:5555
export USER=Administrator
export PASSWORD=manage
```
  
##  Hello world 

The run-hello.sh script performs calls to a simple GET /hello method, which takes a name QP and returns a text message.  
The script takes two arguments:
-   the number of API calls that must be performed. These calls are serialized, not parallelized,
-   the value of the name QP

The following command perfors a sequence of 10 API calls, passing it the name QP value "Bob":
```
./run-hello.sh 10 Bob
```
  
To trigger a HTTP 400 (Bad request) response:
```
./run-hello.sh 1 error400
```
  
To trigger a HTTP 500 (Server error) response:
```
./run-hello.sh 1 error500
```
  
The following call (with the "otel" QP value) makes a call to a Java service that waits 500 ms, then calculates the Fibonacci sequence for 40, and returns a response. it can be use to visualize Open Telemetry traces:
```
./run-hello.sh 1 otel
```

##  Calculate Fibonacci sequence

The GET /fibonacci API method calculates the Fibonacci sequence for value 50, which triggers a high CPU consumption.  
The run-fibo.sh script performs async calls to this API method (it just posts the calculation requests, without waiting for a response.)  
The script takes one argument:
-   the number of API calls that must be performed. These calls are parallelized  
  
The following command makes 5 simultaneous API calls:
```
./run-fibo.sh 5
```

Note: this Fibonacci sequence calculation is very CPU intensive, so avoid launching too many requests in parallel.  

##  Allocate JVM memory

The GET /memory API method allocates an amount of JVM memory, to simulate a momory link situation. Each call allocates 100 Mb memory for at least 60 seconds.    
The run-memory.sh script performs async calls to this API method (it just posts the memory allocation requests, without waiting for a response.)  
The script takes one argument:
-   the number of API calls that must be performed. These calls are parallelized  
  
The following command makes 10 simultaneous API calls:
```
./run-memory.sh 10
```

##  Thread sleep

The GET /sleep API method executes a service that performs a thread sleep. It can be used to trigger a thread starvation situation.  
The run-sleep.sh script performs async calls to this API method (it just invokes the service, without waiting for a response.)  
The script takes two arguments:
-   the number of API calls that must be performed. These calls are parallelized,
-   the sleep waiting time in milliseconds
  
The following command takes 50 threads for 60 seconds 
```
./run-sleep.sh 50 60000
```

##  Messaging

The POST /message/async API method injects a batch of messages into a messageQueue queue.  
The run-message.sh script takes two arguments:
-   the number of messages to be posted (one single API call takes an array of messages in input)
-   the length of each message (the script generates random content up to this length)
  
The following command makes an API call that posts 1000 messages of 10 characters each:
```
./run-message.sh 1000 10
```