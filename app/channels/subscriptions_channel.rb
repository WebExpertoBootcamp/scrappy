class SubscriptionsChannel < ApplicationCable::Channel
  def subscribed
    # Crear un stream para la sala específica de categoría
    category_id = params[:room] || "default_room"
    stream_from "category_#{category_id}"
  end

  def unsubscribed
    # Lógica de limpieza al desuscribirse (si es necesario)
  end
end
