class Vote < ApplicationRecord
  belongs_to :law_project

  validates :vote_choice, inclusion: { in: [true, false] }
  validates :address, presence: { message: "O campo endereço é obrigatório" }
  validates :signed_message, presence: { message: "O campo mensagem assinada é obrigatório" }

  validate :authorized_address

  private 

  def authorized_address
    errors.add(:address, "Endereço não autorizado a votar") if !Authorization.find_by(address: address).present?
  end
end