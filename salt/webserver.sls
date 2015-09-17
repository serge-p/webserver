##### CREATE OS GROUP AND USER   ###### 

www:
  group.present:
    - gid: 4000
  user.present:
    - fullname: Webserver Owner
    - shell: /bin/bash
    - home: /var/www
    - uid: 4000
    - gid: 4000
    - groups:
      - www


##### CREATE DOCUMENT ROOT  ###### 

Document_root:
  file.directory:
    - name: /var/www/svp
    - user: www
    - group: www
    - mode: 755
    - makedirs: True

##### INSTALL PACKAGES   ######


nginx:
  pkg.installed

nodejs:
  pkg.installed:
    - enablerepo: epel

npm:
  pkg.installed:
    - enablerepo: epel

express:
  npm.installed:
    - dir: /var/www/svp
    - user: www

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

# /var/www/svp:
#    npm.bootstrap

/var/www/svp/test.js:
  file.managed:
    - user: www
    - group: www
    - source: 'salt://sources/test.js'

