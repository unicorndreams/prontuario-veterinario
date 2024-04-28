class Animais::AtualizacoesStatusController < ApplicationController
  before_action :set_animal, only: [:edit, :update]

  def edit
  end

  def update
    respond_to do |format|
      if @animal.update(permitted_params)
        format.html { redirect_to animais_path }
      else
        format.turbo_stream { render turbo_stream: turbo_stream.replace("remote_modal", partial: "animais/atualizacoes_status/animal_status_modal", locals: { animal: @animal }) }
      end
    end
  end

  private

  def permitted_params
    params.require(:animal).permit(:status, :recinto_id, :observacoes)
  end

  def set_animal
    @animal = current_user.animais.find(params[:id])
  end

  def trata_boolean(string)
    ActiveRecord::Type::Boolean.new.cast(string)
  end
end
