require 'nokogiri'
require 'open-uri'

class ScrapeProduct
  def self.scrape_and_save_product(url)
    begin
      # Obtener el HTML de la página del producto
      html = URI.open(url)
      doc = Nokogiri::HTML(html)

      # Mostrar el contenido HTML para verificar si se está obteniendo correctamente
      puts doc.to_html

      # Seleccionar los contenedores de productos (ajusta si es necesario)
      products = doc.css('.card')  # Asegúrate de que cada producto esté dentro de un contenedor con la clase .card
      puts "Se encontraron #{products.count} productos."

      # Si no se encuentran productos, puede ser un problema con los selectores
      if products.empty?
        puts "No se encontraron productos. Verifica los selectores CSS."
      else
        # Iterar sobre cada producto y extraer sus datos
        products.each do |product_html|
          product_name = product_html.css('.card-title').text.strip
          product_price = product_html.css('.price-text').text.strip.gsub(/[^\d,.]/, '').to_f # Limpieza del precio

          # Para propósitos de depuración
          puts "Producto: '#{product_name}', Precio: #{product_price}"
          
          # Aquí puedes agregar la lógica para guardar el producto en la base de datos
        end
      end
    rescue StandardError => e
      puts "Error al scrapeando o guardando el producto: #{e.message}"
    end
  end
end
