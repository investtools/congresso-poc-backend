class BlockchainSyncJob < ApplicationJob

  def perform(key, value)
    puts "sincronizando com a blockchain #{key}, #{value}"
    client = Ethereum::HttpClient.new(config["ethereum"]["host"])
    client.default_account = imported_key.address
    contract = Ethereum::Contract.create(client: client, name: "Publisher", address: config["ethereum"]["contract_address"], abi: config["ethereum"]["abi"])
    contract.key = imported_key
    contract.transact_and_wait.publish_one key, value
  end

  def config
    @config ||= YAML.load(File.open("./config/keys.yml"))
  end

  def imported_key
    @imported_key ||= Eth::Key.new priv: config["ethereum"]["private_key"]
  end

end