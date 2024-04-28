class Animais::HistoricosController < ApplicationController
  before_action :set_animal, only: :show

  def show
    @historicos_animal = PaperTrail::Version.where(item_id: @animal.id, item_type: "Animal").order(created_at: :desc)
  end

  private

  def set_animal
    @animal = current_user.animais.find(params[:id])
  end
end
