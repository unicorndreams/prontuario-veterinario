FactoryBot.define do
  factory :historico_animal, class: "HistoricoAnimal" do
    data { Date.today }
    dados_animal { {} }
    animal
  end
end
