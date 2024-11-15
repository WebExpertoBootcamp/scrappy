require 'nokogiri'
require 'open-uri'

module ScrapeJapangame
  def self.scrape(url = "https://japangameonline.com/categoria-producto/soldadura/yihua/", category_id = 8)
    begin
      # Obtener el HTML de la página de productos
      html = URI.open(url)
      doc = Nokogiri::HTML(html)

      # Extraer la ruta de los productos y sus detalles
      products = doc.css('.products .product')
      #puts "Se encontraron #{products.count} productos."

      # Verificar si se encontraron productos
      if products.empty?
        puts "No se encontraron productos. Verifica los selectores CSS."
      else
        # Iterar sobre cada producto y extraer los datos
        products.each do |product|
          name = product.at_css('.dnwoo_product_grid_title a')&.text&.strip
          link = product.at_css('.dnwoo_product_grid_title a')['href']
          price = product.at_css('.woocommerce-Price-amount')&.text&.strip
          description = product.at_css('.product-description')&.text&.strip || "Sin descripción disponible."
          image_url = product.at_css('.dnwoo_product_img img')['src']

          existing_product = Product.find_or_initialize_by(name: name)
          if existing_product.new_record? || existing_product.price != price.gsub(/[^\d.]/, '').to_f || existing_product.updated_at.to_date != Date.today
            existing_product.update(
              name: name,
              url: link,
              description: description,
              price: price.gsub(/[^\d.]/, '').to_f, # Limpia el precio y lo convierte a float
              img_url: image_url,
              category_id: category_id,
              sku: name,
              updated_at: Time.now
            )
            puts "Producto actualizado: #{existing_product.name}"
          else
            puts "Producto no necesita actualización: #{existing_product.name}"
          end

          # Mostrar la información extraída para cada producto
          #puts "Nombre: #{name}"
          #puts "Precio: #{price}"
          #puts "Enlace: #{link}"
          #puts "Imagen: #{image_url}"
          #puts "Descripción: #{description}"
          #puts "-" * 30 # Separador para legibilidad
        end
      end
    rescue StandardError => e
      puts "Error al scrapeando o guardando el producto: #{e.message}"
    end
  end
end