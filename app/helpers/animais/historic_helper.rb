module Animais
  module HistoricHelper
    def formata_descricao_dado_alterado(dado_alterado)
      {
        "identificador" => Animal.human_attribute_name(:identificador),
        "especie_id" => Animal.human_attribute_name(:especie),
        "genero" => Animal.human_attribute_name(:genero),
        "recinto_id" => Animal.human_attribute_name(:recinto),
        "ativo" => Animal.human_attribute_name(:ativo),
        "status" => Animal.human_attribute_name(:status),
        "diagnostico" => Animal.human_attribute_name(:diagnostico),
        "observacoes" => Animal.human_attribute_name(:observacoes),
      }[dado_alterado]
    end

    def formata_valor_dado_alterado(dado_alterado, alteracao)
      {
        "identificador" => lambda { alteracao.to_s },
        "especie_id" => lambda { @current_user.especies.find_by(id: alteracao)&.nome },
        "genero" => lambda { Animal.new(genero: alteracao).genero&.text },
        "recinto_id" => lambda { @current_user.recintos.find_by(id: alteracao)&.nome },
        "ativo" => lambda { alteracao ? "Sim" : "Não"},
        "status" => lambda { Animal.new(status: alteracao).status&.text },
        "diagnostico" => lambda { alteracao.to_s },
        "observacoes" => lambda { alteracao.to_s },
      }[dado_alterado].call
    end
  end
end
