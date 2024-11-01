require 'nokogiri'
require 'open-uri'

module ScrapeHardvisionlr
  def self.scrape(url = "https://www.hardvisionlr.com.ar/componentes-pc/procesadores/", category_id = 2)
    begin
      # Obtener el HTML de la página de productos
      html = URI.open(url)
      doc = Nokogiri::HTML(html)
      # Extraer la ruta de los productos y sus detalles
      products = doc.css('div.col-md-3')
      puts products.count
      products.each do |product|
        name = product['data-nombre']
        link = product.at_css('div.view.overlay.px-20.imagen > a')&.[]('href')
        price = product['data-precio']
        description = product.at_css('div.card-description')&.text&.strip || "Sin descripción disponible."
        image_url = product.at_css('div.view.overlay.px-20.imagen > a > img')&.[]('data-src')
        #sku = product['data-id']
        sku = product.at_css('div.card-body.px-3.pb-0.pt-0 > h6 > span')&.text&.strip

        if name && price && link && sku
          puts "Nombre: #{name}, Precio: #{price.gsub(/[^\d.]/, '').to_f}, Link: #{link}, Descripcion #{description} , SKU: #{sku}, Imagen: #{image_url}"
          existing_product = Product.find_or_initialize_by(sku: sku)
          existing_product.update(
            name: name,
            url: link,
            description: description,
            price: price.gsub(/[^\d.]/, '').to_f, # Limpia el precio y lo convierte a float
            img_url: image_url,
            category_id: category_id,
            sku: sku
          )
        else
          puts "Producto con datos incompletos encontrado."
        end
      end
      nil
    rescue StandardError => e
      puts "Error al scrapeando o guardando el producto: #{e}"
    end
  end
end