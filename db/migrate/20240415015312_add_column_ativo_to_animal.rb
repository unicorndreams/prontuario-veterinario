class AddColumnAtivoToAnimal < ActiveRecord::Migration[7.1]
  def change
    add_column :animais, :ativo, :boolean, default: true
  end
end
