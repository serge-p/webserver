packages: 
  pkg.uptodate

wget:
  pkg.installed

tmux: 
  pkg.installed

vim: 
  pkg.installed

git.latest:
  - name: git@github.com/serg-p/webserver/salt
  - target: /srv/salt
  - rev: master
