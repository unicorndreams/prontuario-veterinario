class AddUserToAnimais < ActiveRecord::Migration[7.1]
  def change
    add_reference :animais, :user, foreign_key: true
  end
end
