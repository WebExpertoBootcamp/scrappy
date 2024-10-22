require 'nokogiri'
require 'open-uri'

# URL de la página que deseas analizar
url = 'https://japangameonline.com/categoria-producto/soldadura/' # Cambia esta URL por la correcta si es necesario

# Cargar el HTML de la página
html = URI.open(url)
doc = Nokogiri::HTML(html)

# Extraer la ruta de los productos y sus detalles
doc.css('.products .product').each do |product|
  # Extraer el nombre del producto
  name = product.at_css('.dnwoo_product_grid_title a')&.text.strip

  # Extraer el enlace del producto
  link = product.at_css('.dnwoo_product_grid_title a')['href']

  # Extraer el precio del producto
  price = product.at_css('.woocommerce-Price-amount')&.text.strip

  # Extraer la imagen del producto
  image_url = product.at_css('.dnwoo_product_img img')['src']

  # Mostrar la información extraída
  puts "Nombre: #{name}"
  puts "Enlace: #{link}"
  puts "Precio: #{price}"
  puts "Imagen: #{image_url}"
  puts "-" * 30 # Separador para mejorar la legibilidad
end
