require 'rails_helper'

RSpec.describe AtivacaoAnimaisController, type: :controller do
  let(:user) { create(:user) }
  let(:animal) { create(:animal, user: user) }

  before do
    session = Session.create!(user: user)
    cookies.signed[:session_token] = session.id
  end

  describe 'PUT update' do
    context 'when asks to update the animal to active true' do
      it 'updates the animal to active true' do
        put :update, params: { id: animal.id, ativo: true }
        animal.reload
        expect(animal.ativo).to be(true)
      end

      it 'redirects to the animais index' do
        put :update, params: { id: animal.id, ativo: true }
        expect(response).to redirect_to(animais_path)
      end
    end

    context 'when asks to update the animal to active false' do
      it 'updates the animal to active false' do
        put :update, params: { id: animal.id, ativo: false }
        animal.reload
        expect(animal.ativo).to be(false)
      end

      it 'redirects to the animais index' do
        put :update, params: { id: animal.id, ativo: false }
        expect(response).to redirect_to(animais_path)
      end
    end

    context 'when asks to update the animal to active true with invalid attributes' do
      it "renders an error template" do
        put :update, params: { id: animal.id, active: true }, format: :turbo_stream
        expect(response.body).to include("<turbo-stream action=\"replace\" target=\"error\"><template></template></turbo-stream>")
      end
    end
  end
end
