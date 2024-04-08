class Recinto < ApplicationRecord
  has_many :animais

  validates :nome, :tipo, presence: true
  validates :nome, :tipo, uniqueness: true
end
