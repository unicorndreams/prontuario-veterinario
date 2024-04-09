class Especie < ApplicationRecord
  has_many :animais
  belongs_to :user

  validates :nome, presence: true
  validates :nome, uniqueness: true
end
