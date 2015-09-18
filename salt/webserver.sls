#
{% set DOCUMENT_ROOT    = "/var/www/svp" %}

##### CREATE OS GROUP AND USER   ###### 

www:
  group.present:
    - gid: 4000
  user.present:
    - fullname: Webserver Owner
    - shell: /bin/bash
    - uid: 4000
    - gid: 4000
    - groups:
      - www


##### CREATE DOCUMENT ROOT  ###### 

{{ DOCUMENT_ROOT }}:
  file.directory:
    - user: www
    - group: www
    - mode: 755
    - makedirs: True

##### INSTALL PACKAGES   ###### 
#
##### Install nginx, to be used as an SSL Breaker, and caching loadbalancer  ###### 

nginx: 
  pkg.installed

##### INSTALL Node JS PACKAGES   ###### 

nodejs:
  pkg.installed:
    - enablerepo: epel

npm:
  pkg.installed:
    - enablerepo: epel

##### Yet another approach to install Node Dependencies, to be used for some more complicated NodeJS apps  ###### 


/var/www/svp/package.json:
  file.serialize:
    - dataset:
        name: test
        description: A package using native versioning
        author: Sergey Paramonov 
        dependencies:
          express: ">= 1.2.0"
        engine: node 0.10.x
    - formatter: json

express:
  npm.installed:
    - user: www
    - dir: {{ DOCUMENT_ROOT }}

forever:
  npm.installed

##### Get latest version of a Main web application and start a webserver   ###### 

/var/www/svp/test.js:
  file.managed:
    - user: www
    - group: www
    - source: 'salt://sources/test.js' 


forever start test.js: 
  cmd.run:
    - cwd: {{ DOCUMENT_ROOT }}
    - user: www
    - require: 
      - npm: forever
      - npm: express