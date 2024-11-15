require 'httparty'
require 'json'

module ScrapeCompragamer
  def self.scrape(url = "https://compragamer.com/productos?cate=48", category_id = 8)
    id_sub= url.split("=").last.to_i
    response = HTTParty.get("https://static.compragamer.com/productos")
    if response.code == 200
      products = JSON.parse(response.body).select { |product| product['id_subcategoria'] == id_sub }
      product_data = products.map do |product|
        name_product = product['imagenes'].first['nombre'].split("_", 2).last
        id_img = product['imagenes'].first['id_producto_imagen']
        link = "https://compragamer.com/producto/#{name_product}_#{id_img}"
        {
          title: product['nombre'],
          description: "Sin descripción disponible.",
          link: link,
          image: "https://imagenes.compragamer.com/productos/compragamer_Imganen_general_#{product['imagenes'].first['nombre']}-grn.jpg",
          price: product['precioEspecial'],
          #sku: product['id_producto'],
          sku: product['codigo_principal'].first

        }
      end
      puts product_data
      puts "Scraping Compragamer..."
      product_data.each do |product|
        existing_product = Product.find_or_initialize_by(sku: product[:sku])
        if existing_product.new_record? || existing_product.price != product[:price] || existing_product.updated_at < Date.today
          existing_product.update(
            name: product[:title],
            url: product[:link],
            description: product[:description],
            price: product[:price],
            img_url: product[:image],
            category_id: category_id,
            sku: product[:sku]
          )
        end
      end
    else
      puts "Error al conectar con la API: #{response.code}"
    end
  end
end