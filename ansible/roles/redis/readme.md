* Per copiare il file di configurazione di Redis.
  * Sulla macchina Vagrant l'ho copiato da `/etc/redis/` in `/home/vagrant`.
  * Gli ho cambiato owner da `redis`:`redis` a `vagrant`:`vagrant`.
  * Poi da locale: `scp -P 2222 -i /home/xpuser/mauro-quaglia/redis-rookie/ansible/.vagrant/machines/vagrant-rds/virtualbox/private_key vagrant@localhost:/home/vagrant/redis.conf .`

* Se si vuole provare il cluster bisogna scaricare dei file apposta.
  * Occhio alla versione, che si acompatibile con quella che stiamo usando.
  * Per esempio: https://github.com/redis/redis/tree/7.4.1/utils/create-cluster
   * Ho dovuto cambiare il `BIN_PATH` a mano perché quello presente non andava bene.

* Per provare a creare il cluster:
  * `root@vagrant-rds:/etc/redis/utils# ./create-cluster.sh start`
  * `root@vagrant-rds:/etc/redis/utils# ./create-cluster.sh create`