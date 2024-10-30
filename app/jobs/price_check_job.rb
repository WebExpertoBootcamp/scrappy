class PriceCheckJob
  include Sidekiq::Job

  def perform
    Product.find_each do |product|
      last_history = product.product_histories.order(created_at: :desc).first

      if last_history && product.price < last_history.price
        # Notificación o acción cuando el precio actual es menor al último registrado
        notify_price_drop(product, last_history.price, product.price)
      end

    end
  end

  private

  def notify_price_drop(product, old_price, new_price)
    # Lógica para notificar a los usuarios o registrar la baja de precio
    puts "El producto #{product.name} ha bajado de precio de #{old_price} a #{new_price}"
    # Aquí podrías enviar una notificación a los usuarios interesados
  end
end