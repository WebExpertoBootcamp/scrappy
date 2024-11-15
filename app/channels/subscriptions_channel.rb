class SubscriptionsChannel < ApplicationCable::Channel
  def subscribed
    # Crear un stream para la sala específica de categoría
    Rails.logger.info "Subscribed with category_id=#{connection.category_id}"
    stream_from "category_#{connection.category_id}"
  end

  def unsubscribed
    # Lógica de limpieza al desuscribirse (si es necesario)
  end
end
