class ProductHistory < ApplicationRecord
  before_create :process_notifications
  belongs_to :product

  private

  def process_notifications

    # Obtiene el último precio registrado (histórico) de este producto
    last_history = ProductHistory.where(product_id: self.product_id).order(id: :desc).first

    # Verifica si el último precio era mayor que el nuevo precio
    if last_history && last_history.price > self.price
      Notification.create(
        product_id: self.product_id,
        status: :pending,
        category_id: self.product.category_id,
        message: "¡Oferta! El producto #{self.product.name} ha bajado de precio de #{last_history.price} a #{self.price}. ¡Adquiérelo ahora en #{self.product.url} !"
      )
    end

    if last_history && last_history.price < self.price
      Notification.create(
        product_id: self.product_id,
        status: :pending,
        category_id: self.product.category_id,
        message: "¡Atencion! El producto #{self.product.name} ha subido de precio de #{last_history.price} a #{self.price}. ¡Adquiérelo ahora en #{self.product.url} !"
      )
    end
  end
end
