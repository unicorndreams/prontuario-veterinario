FactoryBot.define do
  factory :especie, class: "Especie" do
    nome { "Canis lupus familiaris" }
    user
  end
end
