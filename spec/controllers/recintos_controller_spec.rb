require 'rails_helper'

RSpec.describe RecintosController, type: :controller do
  let(:user) { create(:user) }
  let(:recinto) { create(:recinto, user: user, nome: 'Q1') }

  before do
    session = Session.create!(user: user)
    cookies.signed[:session_token] = session.id
  end

  describe 'GET index' do
    it 'assigns @recintos' do
      get :index
      expect(assigns(:recintos)).to eq([recinto])
    end

    it 'renders the index template' do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe 'GET new' do
    it 'assigns a new @recinto' do
      get :new, format: :turbo_stream
      expect(assigns(:recinto)).to be_a_new(Recinto)
    end

    it 'renders the new template' do
      get :new, format: :turbo_stream
      expect(response).to render_template(:new)
    end
  end

  describe 'GET edit' do
    it 'assigns @recinto' do
      get :edit, params: { id: recinto.id }, format: :turbo_stream
      expect(assigns(:recinto)).to eq(recinto)
    end

    it 'renders the edit template' do
      get :edit, params: { id: recinto.id }, format: :turbo_stream
      expect(response).to render_template(:edit)
    end
  end

  describe 'PUT update' do
    context 'with valid attributes' do
      let(:recinto_params) { { nome: 'Q2' } }

      it 'updates the recinto' do
        put :update, params: { id: recinto.id, recinto: recinto_params }
        recinto.reload
        expect(recinto.nome).to eq('Q2')
      end

      it 'redirects to the recintos index' do
        put :update, params: { id: recinto.id, recinto: recinto_params }
        expect(response).to redirect_to(recintos_path)
      end
    end

    context 'with invalid attributes' do
      let(:recinto_params) { { nome: '' } }

      it 'does not update the recinto' do
        put :update, params: { id: recinto.id, recinto: recinto_params }, format: :turbo_stream
        recinto.reload
        expect(recinto.nome).not_to eq(nil)
      end

      it 're-renders the edit modal' do
        put :update, params: { id: recinto.id, recinto: recinto_params }, format: :turbo_stream
        expect(response).to render_template('recintos/_modal')
      end
    end
  end

  describe 'POST create' do
    context 'with valid attributes' do
      let(:recinto_params) { { nome: 'Q2', tipo: 'sala_de_quarentena' } }

      it 'creates a new recinto' do
        expect {
          post :create, params: { recinto: recinto_params }
        }.to change(user.recintos, :count).by(1)
      end

      it 'redirects to the recintos index' do
        post :create, params: { recinto: recinto_params }
        expect(response).to redirect_to(recintos_path)
      end
    end

    context 'with invalid attributes' do
      let(:recinto_params) { { nome: '' } }

      it 'does not save the new recinto' do
        expect {
          post :create, params: { recinto: recinto_params }, format: :turbo_stream
        }.not_to change(user.recintos, :count)
      end

      it 're-renders the new modal' do
        post :create, params: { recinto: recinto_params }, format: :turbo_stream
        expect(response).to render_template("recintos/_modal")
      end
    end
  end

  describe 'DELETE destroy' do
    it 'deletes the recinto' do
      delete :destroy, params: { id: recinto.id }, format: :turbo_stream
      
      expect(user.recintos.exists?(recinto.id)).to be(false)
    end

    it 'returns a turbo stream' do
      delete :destroy, params: {id: recinto.to_param}, format: :turbo_stream
      expect(response.content_type).to eq("text/vnd.turbo-stream.html; charset=utf-8")
      expect(response.body).to include("turbo-stream action=\"remove\" target=\"recinto-#{recinto.id}\"")
    end
  end
end
