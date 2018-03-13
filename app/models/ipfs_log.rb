class IpfsLog < ApplicationRecord
  validates :date, presence: { message: "O campo data é obrigatório" }
  validates :ipfs_meta_key, presence: { message: "O campo ipfs_meta_key é obrigatório" }
  validates :ipfs_value, presence: { message: "O campo ipfs_value é obrigatório" }
end