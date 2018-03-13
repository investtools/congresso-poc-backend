class VoteSyncJob < ApplicationJob

  def perform
    client = IPFS::Client.new host: config["ipfs"]["host"], port: config["ipfs"]["port"]
    File.open("vote.json", 'w') {|f| f.write(Vote.all.to_json) }
    link = client.add 'vote.json'
    IpfsLog.create!(date: Date.today, ipfs_meta_key: config["ipfs"]["vote_meta_key"], ipfs_value: link.hashcode)
    BlockchainSyncJob.perform_later(config["ipfs"]["vote_meta_key"], link.hashcode)
  end

  def config
    @config ||= YAML.load(File.open("./config/keys.yml"))
  end

end