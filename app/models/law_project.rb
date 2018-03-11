class LawProject < ApplicationRecord
  validates :title, presence: { message: "O campo título é obrigatório" }
  validates :text, presence: { message: "O campo texto é obrigatório" }
end