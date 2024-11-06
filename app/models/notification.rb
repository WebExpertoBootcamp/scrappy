class Notification < ApplicationRecord
  belongs_to :product
  belongs_to :category

  enum :status, [
    :pending,       # Estado inicial de la notificación: 0
    :sent,          # Enviada exitosamente: 1
    :not_received,  # No recibida: 2
    :canceled,      # Cancelada antes de enviarse: 3
    :error          # Error durante el envío: 4
  ], prefix: true
end
