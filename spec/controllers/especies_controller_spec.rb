require 'rails_helper'

RSpec.describe EspeciesController, type: :controller do
  let(:user) { create(:user) }
  let(:especie) { create(:especie, user: user, nome: 'Canis lupus familiariss') }

  before do
    session = Session.create!(user: user)
    cookies.signed[:session_token] = session.id
  end

  describe 'GET index' do
    it 'assigns @especies' do
      get :index
      expect(assigns(:especies)).to eq([especie])
    end

    it 'renders the index template' do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe 'GET new' do
    it 'assigns a new @especie' do
      get :new, format: :turbo_stream
      expect(assigns(:especie)).to be_a_new(Especie)
    end

    it 'renders the new template' do
      get :new, format: :turbo_stream
      expect(response).to render_template(:new)
    end
  end

  describe 'GET edit' do
    it 'assigns @especie' do
      get :edit, params: { id: especie.id }, format: :turbo_stream
      expect(assigns(:especie)).to eq(especie)
    end

    it 'renders the edit template' do
      get :edit, params: { id: especie.id }, format: :turbo_stream
      expect(response).to render_template(:edit)
    end
  end

  describe 'PUT update' do
    context 'with valid attributes' do
      let(:especie_params) { { nome: 'Canis lupus familiaris' } }

      it 'updates the especie' do
        put :update, params: { id: especie.id, especie: especie_params }
        especie.reload
        expect(especie.nome).to eq('Canis lupus familiaris')
      end

      it 'redirects to the especies index' do
        put :update, params: { id: especie.id, especie: especie_params }
        expect(response).to redirect_to(especies_path)
      end
    end

    context 'with invalid attributes' do
      let(:especie_params) { { nome: '' } }

      it 'does not update the especie' do
        put :update, params: { id: especie.id, especie: especie_params }, format: :turbo_stream
        especie.reload
        expect(especie.nome).not_to eq(nil)
      end

      it 're-renders the edit modal' do
        put :update, params: { id: especie.id, especie: especie_params }, format: :turbo_stream
        expect(response).to render_template('especies/_modal')
      end
    end
  end

  describe 'POST create' do
    context 'with valid attributes' do
      let(:especie_params) { { nome: 'Canis lupus familiaris' } }

      it 'creates a new especie' do
        expect {
          post :create, params: { especie: especie_params }
        }.to change(user.especies, :count).by(1)
      end

      it 'redirects to the especies index' do
        post :create, params: { especie: especie_params }
        expect(response).to redirect_to(especies_path)
      end
    end

    context 'with invalid attributes' do
      let(:especie_params) { { nome: '' } }

      it 'does not save the new especie' do
        expect {
          post :create, params: { especie: especie_params }, format: :turbo_stream
        }.not_to change(user.especies, :count)
      end

      it 're-renders the new modal' do
        post :create, params: { especie: especie_params }, format: :turbo_stream
        expect(response).to render_template("especies/_modal")
      end
    end
  end

  describe 'DELETE destroy' do
    it 'deletes the especie' do
      delete :destroy, params: { id: especie.id }, format: :turbo_stream
      
      expect(user.especies.exists?(especie.id)).to be(false)
    end

    it 'returns a turbo stream' do
      delete :destroy, params: {id: especie.to_param}, format: :turbo_stream
      expect(response.content_type).to eq("text/vnd.turbo-stream.html; charset=utf-8")
      expect(response.body).to include("turbo-stream action=\"remove\" target=\"especie-#{especie.id}\"")
    end

    context "when the especie has associated animals" do
      let!(:animal) { create(:animal, especie: especie) }

      it "does not delete the especie" do
        delete :destroy, params: { id: especie.id }, format: :turbo_stream
        expect(user.especies.exists?(especie.id)).to be(true)
      end

      it "returns a turbo stream with an error message" do
        delete :destroy, params: { id: especie.id }, format: :turbo_stream
        expect(response.body).to include("turbo-stream action=\"replace\" target=\"error\"")
      end
    end
  end
end
