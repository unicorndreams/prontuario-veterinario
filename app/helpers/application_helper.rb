module ApplicationHelper
  def formata_data_hora(date)
    date.strftime("%d/%m/%Y - %H:%M:%S")
  end
end
