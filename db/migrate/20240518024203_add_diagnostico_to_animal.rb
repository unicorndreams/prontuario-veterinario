class AddDiagnosticoToAnimal < ActiveRecord::Migration[7.1]
  def change
    add_column :animais, :diagnostico, :string
  end
end
