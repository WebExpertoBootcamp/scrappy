class PriceCheckJob
  include Sidekiq::Job

  def perform
    puts "------------------------------PRICECHECK------------------------------"
    Product.find_each do |product|
      # Obtener el último precio en el historial de precios
      last_history = product.product_histories.order(created_at: :desc).first

      # Obtener el precio mínimo registrado anteriormente en el historial
      #min_price = product.product_histories.minimum(:price)

      # Verificar si el precio actual es menor que el último en el historial y el mínimo registrado
      if last_history && product.price < last_history.price
        # Notificación o acción cuando el precio actual es menor que el mínimo histórico
        notify_price_drop(product, last_history.price, product.price)
        #Creo notificacion con estado pendiente
        
      end
    end
  end

  private

  def notify_price_drop(product, old_price, new_price)
    # Lógica para notificar a los usuarios o registrar la baja de precio
    puts "El producto #{product.name} ha bajado de precio de #{old_price} a #{new_price}"

    ActionCable.server.broadcast("category_#{product.category_id}", {
      message: "¡Oferta! El producto #{product.name} ha bajado de precio de #{old_price} a #{new_price}. ¡Adquiérelo ahora en #{product.url}!"
    })
  end
  

end
