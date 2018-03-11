class Authorization < ApplicationRecord
  validates :cpf, presence: { message: "O campo cpf é obrigatório" }
  validates :address, presence: { message: "O campo endereço é obrigatório" }

  validates_uniqueness_of :address, message: "Essa chave já foi autorizada"
end