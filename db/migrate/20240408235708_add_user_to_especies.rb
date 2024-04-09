class AddUserToEspecies < ActiveRecord::Migration[7.1]
  def change
    add_reference :especies, :user, foreign_key: true
  end
end
