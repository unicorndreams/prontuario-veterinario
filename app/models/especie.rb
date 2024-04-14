class Especie < ApplicationRecord
  has_many :animais, dependent: :restrict_with_error
  belongs_to :user

  validates :nome, presence: true
  validates :nome, uniqueness: true
end
