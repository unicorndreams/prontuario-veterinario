class Recinto < ApplicationRecord
  has_many :animais
  belongs_to :user

  validates :nome, :tipo, presence: true
  validates :nome, :tipo, uniqueness: true
end
