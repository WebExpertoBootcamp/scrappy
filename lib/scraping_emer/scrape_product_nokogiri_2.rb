require 'nokogiri'
require 'open-uri'

class ScrapeProduct
  def self.scrape_and_save_product2(url)
    begin
      # Obtener el HTML de la página del producto
      html = URI.open(url)
      doc = Nokogiri::HTML(html)

      # Extraer la ruta de los productos y sus detalles
      products = doc.css('.products .product')
      puts "Se encontraron #{products.count} productos."

      # Si no se encuentran productos, puede ser un problema con los selectores
      if products.empty?
        puts "No se encontraron productos. Verifica los selectores CSS."
      else
        # Iterar sobre cada producto y extraer sus datos
        products.each do |product|
          # Extraer el nombre del producto
          name = product.at_css('.dnwoo_product_grid_title a')&.text.strip

          # Extraer el enlace del producto
          link = product.at_css('.dnwoo_product_grid_title a')['href']

          # Extraer el precio del producto
          price = product.at_css('.woocommerce-Price-amount')&.text.strip

          # Extraer la imagen del producto
          image_url = product.at_css('.dnwoo_product_img img')['src']

          # Extraer la categoría (puedes necesitar ajustar el selector dependiendo del HTML)
          category = Category.last

          # Crear el producto en la base de datos
          Product.create(
            name: name,
            category: category
          )

          # Mostrar la información extraída
          puts "Nombre: #{name}"
        #   puts "Enlace: #{link}"
        #   puts "Precio: #{price}"
        #   puts "Imagen: #{image_url}"
        #   puts "Categoría: #{category}"
          puts "-" * 30 # Separador para mejorar la legibilidad
        end
      end
    rescue StandardError => e
      puts "Error al scrapeando o guardando el producto: #{e.message}"
    end
  end
end

# Para probar el método, carga el archivo en la consola de Rails y ejecuta el siguiente comando:
# ScrapeProduct.scrape_and_save_product2("https://japangameonline.com/categoria-producto/soldadura/")
