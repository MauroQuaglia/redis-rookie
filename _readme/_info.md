# Password
* Per provare ho messo una password (`foobar`) all'utente di default (`default`) di Redis server.
* Quando infatti si cerca di eseguire un comando dalla `redis-cli`, risponderà con `NOAUTH Authentication required.`
  * Basta specificare la password con: `AUTH foobar`
  * Da li in poi posso scrivere tutti i comandi che voglio
  
# Rename comandi
* Ho provato a fare il rename di alcuni comandi.
* Per esempio se da `redis-cli` scrivo `PING` mi dirà `ERR unknown command 'ping'`
  * Basterà usare `PING7`
  * Attenzione a rinominare comandi perché magari sono usati da toole di terze parti e non lo sappiamo. Per esempio potrebbe usarlo Redis Insight o Sidekiq o altro...
  
# Redis Sentinel
* Serve per la replica dei dati.
* Io solo per provare ho messo un Redis con un Sentinel, che ovviamente serve a poco.
* Nel playbook l'ho lasciato commentato così di default non lo installa e mette solo un Redis Standalone

# Redis Cluster
* Fa lo sharding dei dati tra i noid master.
* Ogni nodo master dovrebbe avere uno slave per la replica dei dati di quel master.
* Ho scritto un readme apposta per provare a mettere su a mano un Redis Cluster.
* Nel ruolo di Redis copia anche un file per fare un setup al volo di un cluster, le info sononelreadme del ruolo.
  * Non è strettamente necessario, posso anche fare un cluster a mano. 

# Punti di attenzione
* Non è detto che il __bitmap__ sia sempre meglio e con più performance, per esempio se guardiamoi `c6/benchmark` nel caso considerato il __bitmap__ usa più memoria!
  * C'è sempre da valutare caso per caso.

# Setup per Redis
* Il valore `/proc/sys/vm/swappiness` (Linux) dovrebe essere messo a 1 per fare in modo che venga usata solo minimamente la memoria di __swap__.
* Anche  `overcommit_memory = 1` (Linux) se ci sono strategie per persistere i dati è molto importante impostarlo.
* Anche `maxmemory` sarebbe da impostare (`redis.conf`), con poi un check sulla memoria effettivamentein uso.