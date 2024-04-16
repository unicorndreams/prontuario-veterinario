class Animal < ApplicationRecord
  extend Enumerize

  belongs_to :especie
  belongs_to :recinto
  belongs_to :user
  has_many :historicos_animal, class_name: "HistoricoAnimal", dependent: :destroy

  validates :identificador, presence: true
  validates :identificador, uniqueness: true
  validates :genero, presence: true

  enumerize :genero, in: { macho: 1, femea: 2  }, i18n_scope: "animais_genero", scope: true
  enumerize :status, in: { triagem: 1, aguardando_soltura: 2, obito: 3 }, i18n_scope: "animais_status", scope: true

  scope :por_identificador, ->(identificador) { where("identificador ILIKE ?", "%#{identificador}%") if identificador.present? }
  scope :por_especie, ->(especie_id) { where(especie_id: especie_id) if especie_id.present? }
  scope :por_genero, ->(genero) { where(genero: genero) if genero.present? }
  scope :por_recinto, ->(recinto_id) { where(recinto_id: recinto_id) if recinto_id.present? }
  scope :por_status, ->(status) { where(status: status) if status.present? }
end