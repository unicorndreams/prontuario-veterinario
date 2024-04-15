class ChangeTipoRecintoToInteger < ActiveRecord::Migration[7.1]
  def change
    remove_column :recintos, :tipo, :string
    add_column :recintos, :tipo, :integer
  end
end
