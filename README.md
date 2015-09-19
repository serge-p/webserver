# webserver build example

deploy_webserver.sh

* script to deploy test.js application in AWS cloud, 
* script does not take any args

dependencies: 
~~~

1. install ec2-cli tools and set environment variables as described in AWS doc:
http://docs.aws.amazon.com/AWSEC2/latest/CommandLineReference/set-up-ec2-cli-linux.html

2. create authentication key-pair to access AWS console through API and set 2 following environment variables: 
 export AWS_ACCESS_KEY=XXXXXXXXXXXXXXXXXXXX
 export AWS_SECRET_KEY=XXXXXXXXXXXXXXXXXXXX

~~~


main logic: 
~~~
* generate init shell script 
* start a new t2.micro instance in EC2 
* then bootstrap salt into newly created VM 
* clone this repository and apply highstate in a masterless mode 
* state files are available in folder salt
* example node js app source code is located in ./salt/sources/test.js 
* app will be listening on port 4000 
~~~


drop_webserver.sh 
~~~
script to terminate given EC2 instance, 
script takes instance ID as an argument
deps: (same as for deploy_webserver.sh)
~~~

TODO: 
~~~
* nginx configuration as a caching proxy 
