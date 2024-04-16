class RemoveDefaultStatusAnimal < ActiveRecord::Migration[7.1]
  def change
    change_column_default :animais, :status, nil
  end
end
