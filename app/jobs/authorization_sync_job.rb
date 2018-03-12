class AuthorizationSyncJob < ApplicationJob

  def perform
    puts "rodando o job via scheduler"
  end

end