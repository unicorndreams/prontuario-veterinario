require 'rails_helper'

RSpec.describe Animal, type: :model do
  describe "associations" do
    it { is_expected.to belong_to(:especie) }
    it { is_expected.to belong_to(:recinto).optional }
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:historicos_animal).dependent(:destroy) }
  end

  describe "validations" do
   before { create(:animal) }

    it { is_expected.to validate_presence_of(:identificador) }
    it { is_expected.to validate_presence_of(:genero) }
    it { is_expected.to validate_uniqueness_of(:identificador).scoped_to(:user_id) }
  end

  describe "callbacks" do
    context "quando o status está em branco" do
      let(:animal) { create(:animal, status: nil) }

      it { expect(animal.status).to eq("triagem") }
    end
  end

  describe "scopes" do
    describe ".ativos" do
      let(:animal_ativo) { create(:animal, ativo: true) }
      let(:animal_inativo) { create(:animal, ativo: false) }

      it { expect(described_class.ativos(true)).to match_array([animal_ativo]) }
      it { expect(described_class.ativos(false)).to match_array([animal_inativo]) }
    end

    describe ".por_identificador" do
      let(:animal) { create(:animal, identificador: "123") }

      it { expect(described_class.por_identificador("123")).to match_array([animal]) }
      it { expect(described_class.por_identificador("456")).to be_empty }
      it { expect(described_class.por_identificador("")).to be_empty }
    end

    describe ".por_especie" do
      let(:especie) { create(:especie) }
      let(:animal) { create(:animal, especie: especie) }

      it { expect(described_class.por_especie(especie.id)).to match_array([animal]) }
      it { expect(described_class.por_especie(23)).to be_empty }
      it { expect(described_class.por_especie("")).to be_empty }
    end

    describe ".por_genero" do
      let(:animal) { create(:animal, genero: "macho") }

      it { expect(described_class.por_genero("macho")).to match_array([animal]) }
      it { expect(described_class.por_genero("femea")).to be_empty }
      it { expect(described_class.por_genero("")).to be_empty }
    end

    describe ".por_recinto" do
      let(:recinto) { create(:recinto) }
      let(:animal) { create(:animal, recinto: recinto) }

      it { expect(described_class.por_recinto(recinto.id)).to match_array([animal]) }
      it { expect(described_class.por_recinto(23)).to be_empty }
      it { expect(described_class.por_recinto("")).to be_empty }
    end

    describe ".por_status" do
      let(:animal) { create(:animal, status: "triagem") }

      it { expect(described_class.por_status("triagem")).to match_array([animal]) }
      it { expect(described_class.por_status("obito")).to be_empty }
      it { expect(described_class.por_status("")).to be_empty }
    end
  end
end
