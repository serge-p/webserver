packages: 
  pkg.uptodate

wget:
  pkg.installed

tmux: 
  pkg.installed

vim: 
  pkg.installed

git@github.com/serg-p/webserver/salt:
  git.latest:
    - name: git@github.com/serg-p/webserver/salt
    - target: /srv/salt
    - rev: master
    - force_clone: True 
    - require:
      - pkg: git
