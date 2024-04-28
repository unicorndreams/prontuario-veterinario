require 'rails_helper'

RSpec.describe AnimaisController, type: :controller do
  let(:user) { create(:user) }
  let(:animal) { create(:animal, user: user, identificador: 'XJDKFH') }

  before do
    session = Session.create!(user: user)
    cookies.signed[:session_token] = session.id
  end

  describe 'GET index' do
    it 'assigns @animais' do
      get :index
      expect(assigns(:animais)).to eq([animal])
    end

    it 'renders the index template' do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe 'GET new' do
    it 'assigns a new @animal' do
      get :new, format: :turbo_stream
      expect(assigns(:animal)).to be_a_new(Animal)
    end

    it 'renders the new template' do
      get :new, format: :turbo_stream
      expect(response).to render_template(:new)
    end
  end

  describe 'GET edit' do
    it 'assigns @animal' do
      get :edit, params: { id: animal.id }, format: :turbo_stream
      expect(assigns(:animal)).to eq(animal)
    end

    it 'renders the edit template' do
      get :edit, params: { id: animal.id }, format: :turbo_stream
      expect(response).to render_template(:edit)
    end
  end

  describe 'PUT update' do
    context 'with valid attributes' do
      let(:animal_params) { { identificador: 'XJDKFI' } }

      it 'updates the animal' do
        put :update, params: { id: animal.id, animal: animal_params }
        animal.reload
        expect(animal.identificador).to eq('XJDKFI')
      end

      it 'redirects to the animais index' do
        put :update, params: { id: animal.id, animal: animal_params }
        expect(response).to redirect_to(animais_path)
      end
    end

    context 'with invalid attributes' do
      let(:animal_params) { { identificador: '' } }

      it 'does not update the animal' do
        put :update, params: { id: animal.id, animal: animal_params }, format: :turbo_stream
        animal.reload
        expect(animal.identificador).not_to eq(nil)
      end

      it 're-renders the edit modal' do
        put :update, params: { id: animal.id, animal: animal_params }, format: :turbo_stream
        expect(response).to render_template('animais/_modal')
      end
    end
  end

  describe 'POST create' do
    context 'with valid attributes' do
      let(:especie) { create(:especie) }
      let(:recinto) { create(:recinto) }
      let(:animal_params) { { identificador: 'XJDKF', especie_id: especie.id, recinto_id: recinto.id, genero: 1 } }

      it 'creates a new animal' do
        expect {
          post :create, params: { animal: animal_params }
        }.to change(user.animais, :count).by(1)
      end

      it 'redirects to the animais index' do
        post :create, params: { animal: animal_params }
        expect(response).to redirect_to(animais_path)
      end
    end

    context 'with invalid attributes' do
      let(:animal_params) { { identificador: '' } }

      it 'does not save the new animal' do
        expect {
          post :create, params: { animal: animal_params }, format: :turbo_stream
        }.not_to change(user.animais, :count)
      end

      it 're-renders the new modal' do
        post :create, params: { animal: animal_params }, format: :turbo_stream
        expect(response).to render_template("animais/_modal")
      end
    end
  end

  describe 'DELETE destroy' do
    it 'deletes the animal' do
      delete :destroy, params: { id: animal.id }, format: :turbo_stream
      
      expect(user.animais.exists?(animal.id)).to be(false)
    end

    it 'returns a turbo stream' do
      delete :destroy, params: { id: animal.id }, format: :turbo_stream
      expect(response.content_type).to eq("text/vnd.turbo-stream.html; charset=utf-8")
      expect(response.body).to include("turbo-stream action=\"remove\" target=\"animal-#{animal.id}\"")
    end
  end
end
