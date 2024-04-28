require 'rails_helper'

RSpec.describe Animais::AtualizacoesStatusController, type: :controller do
  let(:user) { create(:user) }
  let(:animal) { create(:animal, user: user) }
  let(:recinto) { create(:recinto) }

  before do
    session = Session.create!(user: user)
    cookies.signed[:session_token] = session.id
  end

  describe "GET edit" do
    it "renders the edit template" do
      get :edit, params: { id: animal.id }, format: :turbo_stream
      expect(response).to render_template(:edit)
    end
  end

  describe "PATCH update" do
    context "with valid params" do
      let(:animal_params) { { status: "obito", recinto_id: recinto.id, observacoes: "" } }

      it 'updates the animal' do
        put :update, params: { id: animal.id, animal: animal_params }, format: :html
        animal.reload
        expect(animal.status).to eq("obito")
      end

      it "redirects to animais_path" do
        patch :update, params: { id: animal.id, animal: animal_params }, format: :html
        expect(response).to redirect_to(animais_path)
      end
    end

    context "with invalid params" do
      let(:animal_params) { { status: "obito", recinto_id: "", observacoes: "" } }

      it 'does not update the animal' do
        put :update, params: { id: animal.id, animal: animal_params }, format: :turbo_stream
        animal.reload
        expect(animal.status).to eq("triagem")
      end


      it "re-renders the edit modal" do
        patch :update, params: { id: animal.id, animal: animal_params }, format: :turbo_stream
        expect(response).to render_template("animais/atualizacoes_status/_animal_status_modal")
      end
    end
  end
end
