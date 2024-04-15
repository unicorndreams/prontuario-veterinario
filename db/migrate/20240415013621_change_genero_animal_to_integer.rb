class ChangeGeneroAnimalToInteger < ActiveRecord::Migration[7.1]
  def change
    remove_column :animais, :genero, :string
    add_column :animais, :genero, :integer
  end
end
