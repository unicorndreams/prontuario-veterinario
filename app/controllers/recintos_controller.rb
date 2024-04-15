class RecintosController < ApplicationController
  before_action :set_recinto, only: [:edit, :update, :destroy]

  def index
    @recintos = current_user.recintos.order(:nome)
  end

  def new
    @recinto = current_user.recintos.new
  end

  def edit
  end

  def update
    respond_to do |format|
      if @recinto.update(recinto_params)
        redirect_to recintos_path
      else
        format.turbo_stream { render turbo_stream: turbo_stream.replace("remote_modal", partial: "recintos/modal", locals: { recinto: @recinto }) }
      end
    end
  end

  def create
    @recinto = current_user.recintos.new(recinto_params)

    respond_to do |format|
      if @recinto.save
        redirect_to recintos_path
      else
        format.turbo_stream { render turbo_stream: turbo_stream.replace("remote_modal", partial: "recintos/modal", locals: { recinto: @recinto }) }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @recinto.destroy
        format.turbo_stream { render turbo_stream: turbo_stream.remove("recinto-#{@recinto.id}") }
      else
        format.turbo_stream { render turbo_stream: turbo_stream.replace("error", partial: "shared/error", locals: { error: @recinto.errors.full_messages.join(", ") }) }
      end
    end
  end

  private

  def set_recinto
    @recinto = current_user.recintos.find(params[:id])
  end

  def recinto_params
    params.require(:recinto).permit(:nome, :tipo)
  end
end
