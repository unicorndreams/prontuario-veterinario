class Especie < ApplicationRecord
  has_many :animais

  validates :nome, presence: true
  validates :nome, uniqueness: true
end
