# Info
* Ho fatto un `docker image history --no-trunc redis:7.2.4-alpine3.19` per vedere quale versione di Redis stava veramente usando, indipendentemente dal tag dell'immagine.
  * Ho trovato `ENV REDIS_DOWNLOAD_URL=http://download.redis.io/releases/redis-7.2.4.tar.gz`
  * Quindi diciamo un Redis __7.2.4__ come ci aspettavamo.
* Ora voglio capire che file di configurazione usa un Redis 7.2.4:
  * Tirato su Vagrant e installato un Redis 7.2.4: 
    * Tuttavia questa versione di Redis richiede anche una libreria aggiuntiva che si chiama "redis-tool".
    * Installate con ansible su Vagrant:
      ```
      - "redis-tools=6:7.4.1-1rl1~bullseye1"
      - "redis-server=6:7.4.1-1rl1~bullseye1"
      ``` 
    * Dopodiché sulla macchina avevo il file di configurazione della 7.4.1.
    * Me lo sono copiato in locale con