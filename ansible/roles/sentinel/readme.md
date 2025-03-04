# Info Varie
* Per copiare il file di configurazione di Sentinel.
  * Sulla macchina Vagrant l'ho copiato da `/etc/redis/` in `/home/vagrant`.
  * Gli ho cambiato owner da `redis`:`redis` a `vagrant`:`vagrant`.
  * Poi da locale: `scp -P 2222 -i /home/xpuser/mauro-quaglia/redis-rookie/ansible/.vagrant/machines/vagrant-rds/virtualbox/private_key vagrant@localhost:/home/vagrant/sentinel.conf .`
  
* Funziona più o meno così:
  * Il Client Ruby invece di contattare direttamente il Redis master contatta Sentinel.
  * Sentinel (in base a suoi meccanismi) gli ritorna un indirizzo da chiamare, Redis master o Redis slave.
  * Al che poi il Client chiama l'indirizzo che gli ha detto Sentinel.
  * La comunicazione tra i master e i sentinel avviene tramite Pub/Sub.
    * Infatti se c'è attivo Sentinel e da CLI faccio `PUBSUB CHANNELS` vedrò: `1) "__sentinel__:hello"`
