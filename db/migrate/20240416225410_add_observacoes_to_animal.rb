class AddObservacoesToAnimal < ActiveRecord::Migration[7.1]
  def change
    add_column :animais, :observacoes, :string
  end
end
