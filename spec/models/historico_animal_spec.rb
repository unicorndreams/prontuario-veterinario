require 'rails_helper'

RSpec.describe HistoricoAnimal, type: :model do
  describe "associations" do
    it { is_expected.to belong_to(:animal) }
    it { is_expected.to belong_to(:user) }
  end
end
