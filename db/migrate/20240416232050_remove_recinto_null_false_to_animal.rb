class RemoveRecintoNullFalseToAnimal < ActiveRecord::Migration[7.1]
  def change
    change_column_null :animais, :recinto_id, true
  end
end
