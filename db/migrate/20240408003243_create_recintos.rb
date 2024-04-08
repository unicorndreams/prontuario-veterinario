class CreateRecintos < ActiveRecord::Migration[7.1]
  def change
    create_table :recintos do |t|
      t.string :nome
      t.string :tipo

      t.timestamps
    end
  end
end
