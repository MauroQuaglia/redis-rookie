# IP di Vagrant

* Per decidere che IP dare alla macchina Vagrant posso guardare le interfacce di rete.
  * `ip a`
  * E vedere gli host disponibile per `vboxnet0`
  * Esempio se faccio `sudo nmap -sn  192.168.56.0/24` vedrò che la macchina Vagrant non c'è.
  * Se tiro su la macchina Vagrant e rifaccio il comando vedrò che la macchina è visibile.