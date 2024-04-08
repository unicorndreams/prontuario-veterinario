class CreateEspecies < ActiveRecord::Migration[7.1]
  def change
    create_table :especies do |t|
      t.string :nome

      t.timestamps
    end
  end
end
