class AddUserToRecintos < ActiveRecord::Migration[7.1]
  def change
    add_reference :recintos, :user, foreign_key: true
  end
end
