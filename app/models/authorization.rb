class Authorization < ApplicationRecord
  validates :cpf, presence: { message: "O campo cpf é obrigatório" }
  validates :address, presence: { message: "O campo address é obrigatório" }
end