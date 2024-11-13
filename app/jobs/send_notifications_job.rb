class SendNotificationsJob
  include Sidekiq::Job

  def perform
    # Selecciona notificaciones pendientes de envío en las últimas 48 horas
    Notification.where(status: [:pending, :not_received])
                .where('created_at >= ?', 48.hours.ago)
                .find_each do |notification|
      # Intenta enviar la notificación
      notify(notification)
    end
  end

  private

  def notify(notification)
    
    # Lógica para enviar la notificación mediante WebSocket
    lower_price = ProductHistory.where(product_id: notification.product_id)
                                         .where('created_at >= ?', 1.month.ago)
                                         .minimum(:price)

    higher_price = ProductHistory.where(product_id: notification.product_id)
                                          .where('created_at >= ?', 1.month.ago)
                                          .maximum(:price)
    periodo = 'mensual'
    # Envío de la notificación y manejo de respuesta de clientes
    result = ActionCable.server.broadcast("category_#{notification.category_id}", {
      message: notification.message,
      product: notification.product,
      lower_price: lower_price,
      higher_price: higher_price,
      periodo: periodo
    })
      puts "Enviando notificación #{notification.id}... #{result}"
    # Si no hay clientes escuchando, marcar como no recibida
    if result.zero?
      notification.update(status: :not_received)
    else
      notification.update(status: :sent)
    end
  rescue => e
    # En caso de error, registrar y actualizar el estado
    Rails.logger.error "Error al enviar la notificación #{notification.id}: #{e.message}"
    new_message = "#{notification.message} |°°| Error al enviar la notificación #{notification.id}: #{e.message}"
    notification.update(message: new_message)
    notification.update(status: :error)
  end
end
