class VoteSyncJob < ApplicationJob

  def perform
    puts "rodando o job de votos via scheduler"
  end

end