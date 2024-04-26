FactoryBot.define do
  factory :animal, class: "Animal" do
    identificador { "AZBHE" }
    especie
    recinto
    genero { 1 }
    ativo { true }
    status { 1 }
    observacoes { "" }
    user
  end
end
