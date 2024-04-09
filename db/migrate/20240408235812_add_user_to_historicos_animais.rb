class AddUserToHistoricosAnimais < ActiveRecord::Migration[7.1]
  def change
    add_reference :historicos_animais, :user, foreign_key: true
  end
end
