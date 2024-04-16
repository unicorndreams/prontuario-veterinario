class ChangeStatusAnimalToInteger < ActiveRecord::Migration[7.1]
  def change
    remove_column :animais, :status, :string
    add_column :animais, :status, :integer, default: 1
  end
end
