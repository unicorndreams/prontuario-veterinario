class Recinto < ApplicationRecord
  extend Enumerize

  has_many :animais, dependent: :restrict_with_error
  belongs_to :user

  validates :nome, :tipo, presence: true
  validates :nome, uniqueness: true

  enumerize :tipo, in: { ambulatorio: 1, sala_de_quarentena: 2  }, i18n_scope: "tipos_recinto", scope: true
end
