class AnimaisController < ApplicationController
  before_action :set_filtro, only: :index
  before_action :set_animal, only: [:edit, :update, :destroy, :activation_animal, :historic, :edit_status_animal, :update_status_animal]

  def index  
    @animais = current_user
               .animais
               .includes(:especie, :recinto)
               .ativos(trata_boolean(@filtros[:ativo]))
               .por_identificador(@filtros[:identificador].to_s)
               .por_especie(@filtros[:especie_id].to_s)
               .por_genero(@filtros[:genero].to_s)
               .por_recinto(@filtros[:recinto_id].to_s)
               .por_status(@filtros[:status].to_s)
               .order(:identificador)
  end

  def new
    @animal = current_user.animais.new
  end

  def edit
  end

  def update
    respond_to do |format|
      if @animal.update(animal_params)
        format.html { redirect_to animais_path }
      else
        format.turbo_stream { render turbo_stream: turbo_stream.replace("remote_modal", partial: "animais/modal", locals: { animal: @animal }) }
      end
    end
  end

  def create
    @animal = current_user.animais.new(animal_params)

    respond_to do |format|
      if @animal.save
        format.html { redirect_to animais_path }
      else
        format.turbo_stream { render turbo_stream: turbo_stream.replace("remote_modal", partial: "animais/modal", locals: { animal: @animal }) }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @animal.destroy
        format.turbo_stream { render turbo_stream: turbo_stream.remove("animal-#{@animal.id}") }
      else
        format.turbo_stream { render turbo_stream: turbo_stream.replace("error", partial: "shared/error", locals: { error: @animal.errors.full_messages.join(", ") }) }
      end
    end
  end

  def activation_animal
    ativo = trata_boolean(params[:ativo])

    respond_to do |format|
      if @animal.update(ativo: ativo)
        format.html { redirect_to animais_path }
      else
        format.turbo_stream { render turbo_stream: turbo_stream.replace("error", partial: "shared/error", locals: { error: "Ocorreu um erro ao atualizar o animal." }) }
      end
    end
  end

  def edit_status_animal
  end

  def update_status_animal
    respond_to do |format|
      animal_params = params[:animal]

      if @animal.update(recinto_id: animal_params[:recinto_id], observacoes: animal_params[:observacoes], status: animal_params[:status])
        format.html { redirect_to animais_path }
      else
        format.turbo_stream { render turbo_stream: turbo_stream.replace("error", partial: "shared/error", locals: { error: "Ocorreu um erro ao atualizar o status do animal." }) }
      end
    end
  end

  def historic
    @historicos_animal = PaperTrail::Version.where(item_id: @animal.id, item_type: "Animal").order(created_at: :desc)
  end


  def limpar_filtro
    session.delete(:filtros)
    redirect_to animais_path
  end

  private

  def set_animal
    @animal = current_user.animais.find(params[:id])
  end

  def animal_params
    params.require(:animal).permit(:identificador, :especie_id, :genero, :recinto_id, :ativo, :observacoes)
  end

  def trata_boolean(string)
    ActiveRecord::Type::Boolean.new.cast(string)
  end

  def set_filtro
    session[:filtros] = params.extract!(:ativo, :identificador, :especie_id, :genero, :recinto_id, :status) if params[:commit].present?
    @filtros = session[:filtros] || {}
    @filtros[:ativo] ||= true
  end
end
