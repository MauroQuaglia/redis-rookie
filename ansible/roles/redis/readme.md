* Per copiare il file di configurazione di Redis.
  * Sulla macchina Vagrant l'ho copiato da `/etc/redis/` in `/home/vagrant`.
  * Gli ho cambiato owner da `redis`:`redis` a `vagrant`:`vagrant`.
  * Poi da locale: `scp -P 2222 -i /home/xpuser/mauro-quaglia/redis-rookie/ansible/.vagrant/machines/vagrant-rds/virtualbox/private_key vagrant@localhost:/home/vagrant/redis.conf .`
