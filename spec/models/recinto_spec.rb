require 'rails_helper'

RSpec.describe Recinto, type: :model do
  describe "associations" do
    it { is_expected.to have_many(:animais).dependent(:restrict_with_error) }
    it { is_expected.to belong_to(:user) }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:nome) }
    it { is_expected.to validate_presence_of(:tipo) }
    it { is_expected.to validate_uniqueness_of(:nome).scoped_to(:user_id) }
  end
end
