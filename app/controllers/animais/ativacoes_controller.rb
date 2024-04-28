class Animais::AtivacoesController < ApplicationController
  before_action :set_animal, only: :update

  def update
    ativo = trata_boolean(params[:ativo])

    respond_to do |format|
      if !ativo.nil? && @animal.update(ativo: ativo)
        format.html { redirect_to animais_path }
      else
        format.turbo_stream { render turbo_stream: turbo_stream.replace("error", partial: "shared/error", locals: { error: "Ocorreu um erro ao atualizar o animal." }) }
      end
    end
  end 

  private

  def permitted_params
    params.permit(:ativo)
  end

  def set_animal
    @animal = current_user.animais.find(params[:id])
  end

  def trata_boolean(string)
    ActiveRecord::Type::Boolean.new.cast(string)
  end
end
