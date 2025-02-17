require_relative('../redis_client_base.rb')

class BankTransaction < RedisClientBase
  def initialize(from, to)
    @from = from
    @to = to
    super()
  end

  def setup
    @client.set("MQ", 100)
    @client.set("SS", 100)
  end

  def transfer(value)
    # Non riesco a fare un discard perché la libreria di Ruby "redis" non permette di usare multi senza un blocco.
    @client.multi do |multi|
      # Eseguite in maniera atomica, tra una e l'altra nessuno può scrivere altro.
      # Se una delle due fallisce (per vari motivi) comunque l'altra viene eseguita, non c'è un meccanismo di rollback automatico.
      multi.decrby(@from, value)
      multi.incrby(@to, value)
    end
  end
end


bt = BankTransaction.new('MQ', 'SS')
bt.setup
bt.transfer(20)
bt.transfer(20)
bt.close_connection