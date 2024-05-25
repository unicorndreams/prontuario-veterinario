class Animal < ApplicationRecord
  has_paper_trail on: [:create, :update]

  extend Enumerize

  belongs_to :especie
  belongs_to :recinto
  belongs_to :user
  has_many :historicos_animal, class_name: "HistoricoAnimal", dependent: :destroy

  validates :identificador, presence: true
  validates :identificador, uniqueness: { scope: :user_id }
  validates :genero, presence: true

  before_save -> { self.status = :triagem if status.blank? }

  enumerize :genero, in: { indeterminado: 0, macho: 1, femea: 2, macho_castrado: 3, femea_castrada: 4, macho_esterilizado: 5, femea_esterilizada: 6, hermafrodita: 7, assexuado: 8  }, i18n_scope: "animais_genero", scope: true
  enumerize :status, in: { triagem: 1, isolamento: 2, ambulatorio: 3, tratamento_intensivo: 4, creche: 5, quarentena: 6, em_reabilitacao: 7, treinamento: 8, aguardando_soltura: 9, soltura: 10, obito: 11, eutanasia: 12, fuga: 13, furto: 14, roubo: 15, predacao: 16 }, i18n_scope: "animais_status", scope: true

  scope :ativos, ->(ativo) { where(ativo: ativo) }
  scope :por_identificador, ->(identificador) { where("identificador ILIKE ?", "%#{identificador}%") if identificador.present? }
  scope :por_especie, ->(especie_id) { where(especie_id: especie_id) if especie_id.present? }
  scope :por_genero, ->(genero) { where(genero: genero) if genero.present? }
  scope :por_recinto, ->(recinto_id) { where(recinto_id: recinto_id) if recinto_id.present? }
  scope :por_status, ->(status) { where(status: status) if status.present? }
end
