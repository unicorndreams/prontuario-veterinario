class CreateAnimais < ActiveRecord::Migration[7.1]
  def change
    create_table :animais do |t|
      t.string :identificador
      t.string :genero
      t.string :status, default: "triagem"
      t.references :especie, null: false, foreign_key: true
      t.references :recinto, null: false, foreign_key: true

      t.timestamps
    end
  end
end
