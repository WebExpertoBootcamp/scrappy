require 'nokogiri'
require 'open-uri'

class ScrapeProduct
  def self.scrape_and_save_products(url, category)
    begin
      # Obtener el HTML de la página de productos
      html = URI.open(url)
      doc = Nokogiri::HTML(html)

      # Extraer la ruta de los productos y sus detalles
      products = doc.css('.products .product')
      puts "Se encontraron #{products.count} productos."

      # Verificar si se encontraron productos
      if products.empty?
        puts "No se encontraron productos. Verifica los selectores CSS."
      else
        # Iterar sobre cada producto y extraer los datos
        products.each do |product|
          # Extraer el nombre del producto
          name = product.at_css('.dnwoo_product_grid_title a')&.text&.strip

          # Extraer el enlace del producto
          link = product.at_css('.dnwoo_product_grid_title a')['href']

          # Extraer el precio del producto
          price = product.at_css('.woocommerce-Price-amount')&.text&.strip

          # Extraer la descripción (aquí puedes ajustar el selector si es necesario)
          description = product.at_css('.product-description')&.text&.strip || "Sin descripción disponible."

          # Extraer la imagen del producto
          image_url = product.at_css('.dnwoo_product_img img')['src']

          # Crear el producto en la base de datos
          Product.create(
            name: name,
            description: description,
            price: price.gsub(/[^\d.]/, '').to_f, # Limpia el precio y lo convierte a float
            url: link,
            img_url: image_url,
            category: category
          )

          # Mostrar la información extraída para cada producto
          puts "Nombre: #{name}"
          puts "Precio: #{price}"
          puts "Enlace: #{link}"
          puts "Imagen: #{image_url}"
          puts "Descripción: #{description}"
          puts "-" * 30 # Separador para legibilidad
        end
      end
    rescue StandardError => e
      puts "Error al scrapeando o guardando el producto: #{e.message}"
    end
  end
end

# Para probar el método, carga el archivo en la consola de Rails y ejecuta el siguiente comando:
# rails c
# load 'lib/scraping_nokogiri/scraper_japangame.rb'
# category = Category.last
# category = Category.find_by(name: "Soldadores y Estaciones de trabajo") 
# ScrapeProduct.scrape_and_save_products("https://japangameonline.com/categoria-producto/soldadura/", category)
