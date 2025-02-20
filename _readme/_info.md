# Password
* Per provare ho messo una password (`foobar`) all'utente di default (`default`) di Redis server.
* Quando infatti si cerca di eseguire un comando dalla `redis-cli`, risponderà con `NOAUTH Authentication required.`
  * Basta specificare la password con: `AUTH foobar`
  * Da li in poi posso scrivere tutti i comandi che voglio
  
# Rename comandi
* Ho provato a fare il rename di alcuni comandi.
* Per esempio se da `redis-cli` scrivo `PING` mi dirà `ERR unknown command 'ping'`
  * Basterà usare `PING7`