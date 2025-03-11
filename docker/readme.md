# Info
* Ho fatto un `docker image history --no-trunc redis:7.2.4-alpine3.19` per vedere quale versione di Redis stava veramente usando, indipendentemente dal tag dell'immagine.
  * Ho trovato `ENV REDIS_DOWNLOAD_URL=http://download.redis.io/releases/redis-7.2.4.tar.gz`
  * Quindi diciamo un Redis __7.2.4__ come ci aspettavamo.
* Ora voglio capire che file di configurazione usa un Redis 7.2.4:
  * Tirato su Vagrant e installato un Redis 7.2.4: 
    * Tuttavia questa versione di Redis richiede anche una libreria aggiuntiva che si chiama "redis-tool".
    * Installate con ansible su Vagrant:
      ```
      - "redis-tools=6:7.2.4-1rl1~bullseye1"
      - "redis-server=6:7.2.4-1rl1~bullseye1"
      ``` 
    * Dopodiché sulla macchina avevo il file di configurazione della 7.4.1.
    * Me lo sono copiato in locale con `scp -i /home/xpuser/mauro-quaglia/redis-rookie/ansible/.vagrant/machines/vagrant-rds/virtualbox/private_key -P 2222 vagrant@localhost:/home/vagrant/redis.conf .`
* Tuttavia questo procedimento non va benissimo, perché se diamo questo stesso file all'immagine di docker si lamenta per esempio per i path.
* Quindi seguito altro procedimento che è più sicuro, vedi sotto.

# Configurazione
* Seguite le istruzioni di `https://hub.docker.com/_/redis` per creare il Dockerfile corretto.
  * Comunque manca la parte dei permessi che è da aggiungere.
* Sono partito dalla versione base `redis:7.2.4-alpine3.19` e poi ho scaricato le configurazioni tramite il `RedisDownloaderConfig` in `docker/configs/settings.alpine-original.txt`
* Ho verificato che le configurazioni originali, quelle di quando parte senza nessun file di configurazione e le configurazioni di quando parte con un file di configurazione completamente vuoto sono itentiche. 
* Poi ho verificato che mettendo in un file solo le configurazioni che voglio e facendolo partire con quel file, Redis parte con le sue configurazioni di default e poi fa il merge con quelle che gli do io.
* Quindi basta capire quali configurazioni vogliamo cambiare e specificare solo quelle.
  * Un po' come facciamo con il file `postgresql.auto.conf`!

# Sidekiq
* Dato che lo usiamo solo con Sidekiq, per la configurazione di Redis bisogna leggere: 
  * https://github.com/sidekiq/sidekiq/wiki/Using-Redis

# Log
* I log che normalmente si trovano `/var/log/redis/` vengono scritti su `STDOUT` e `STDERR` nel containerper impostazione predefinita.