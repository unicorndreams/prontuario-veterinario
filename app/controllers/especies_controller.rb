class EspeciesController < ApplicationController
  before_action :set_especie, only: [:edit, :update, :destroy]

  def index
    @especies = current_user.especies.order(:nome).page(params[:page] || 1).per(30)
  end

  def new
    @especie = current_user.especies.new
  end

  def edit
  end

  def update
    respond_to do |format|
      if @especie.update(especie_params)
        format.html { redirect_to especies_path }
      else
        format.turbo_stream { render turbo_stream: turbo_stream.replace("remote_modal", partial: "especies/modal", locals: { especie: @especie }) }
      end
    end
  end

  def create
    @especie = current_user.especies.new(especie_params)

    respond_to do |format|
      if @especie.save
        format.html { redirect_to especies_path }
      else
        format.turbo_stream { render turbo_stream: turbo_stream.replace("remote_modal", partial: "especies/modal", locals: { especie: @especie }) }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @especie.destroy
        format.turbo_stream { render turbo_stream: turbo_stream.remove("especie-#{@especie.id}") }
      else
        format.turbo_stream { render turbo_stream: turbo_stream.replace("error", partial: "shared/error", locals: { error: @especie.errors.full_messages.join(", ") }) }
      end
    end
  end

  private

  def set_especie
    @especie = current_user.especies.find(params[:id])
  end

  def especie_params
    params.require(:especie).permit(:nome)
  end
end
