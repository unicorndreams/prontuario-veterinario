module Animais
  module HistoricHelper
    def formata_descricao_dado_alterado(dado_alterado)
      {
        "identificador" => Animal.human_attribute_name(:identificador),
        "especie_id" => Animal.human_attribute_name(:especie),
        "genero" => Animal.human_attribute_name(:genero),
        "recinto_id" => Animal.human_attribute_name(:recinto),
        "ativo" => Animal.human_attribute_name(:ativo),
        "status" => Animal.human_attribute_name(:status)
      }[dado_alterado]
    end

    def formata_valor_dado_alterado(dado_alterado, alteracao)
      {
        "identificador" => lambda { alteracao.to_s },
        "especie_id" => lambda { Especie.find_by(id: alteracao)&.nome },
        "genero" => lambda { Animal.new(genero: alteracao).genero&.text },
        "recinto_id" => lambda { Recinto.find_by(id: alteracao)&.nome },
        "ativo" => lambda { alteracao ? "Sim" : "Não"},
        "status" => lambda { Animal.new(status: alteracao).status&.text }
      }[dado_alterado].call
    end
  end
end
