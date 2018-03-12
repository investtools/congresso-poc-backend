require 'sidekiq'
require 'sidekiq/scheduler'

Sidekiq.configure_client do |config|
  config.redis = { url: 'redis://localhost:6379/12' }
end

Sidekiq.configure_server do |config|
  config.redis = { url: 'redis://localhost:6379/12' }
  config.on(:startup) do
    config.server_middleware do |chain|
      chain.add Sidekiq::Status::ServerMiddleware
    end
    config.client_middleware do |chain|
      chain.add Sidekiq::Status::ClientMiddleware
    end
    unless ENV['DISABLE_SCHEDULER'] == 'true'
      Sidekiq.schedule = YAML.load_file(File.expand_path('../../scheduler.yml', __FILE__))
      Sidekiq::Scheduler.reload_schedule!
    end
  end
end