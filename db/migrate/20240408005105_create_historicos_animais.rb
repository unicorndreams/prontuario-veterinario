class CreateHistoricosAnimais < ActiveRecord::Migration[7.1]
  def change
    create_table :historicos_animais do |t|
      t.datetime :data
      t.references :animal, null: false, foreign_key: true
      t.jsonb :dados_animal

      t.timestamps
    end
  end
end
