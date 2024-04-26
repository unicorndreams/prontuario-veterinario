FactoryBot.define do
  factory :recinto, class: "Recinto" do
    nome { "Recinto 1" }
    tipo { :ambulatorio }
    user
  end
end
