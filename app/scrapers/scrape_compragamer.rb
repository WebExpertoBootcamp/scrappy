=begin
require 'httparty'
=end
require 'selenium-webdriver'
require 'nokogiri'
module ScrapeCompragamer
  def self.scrape(url = "https://compragamer.com/productos?cate=48", category_id = 8)
    options = Selenium::WebDriver::Edge::Options.new
    options.add_argument('--headless') # Ejecuta el navegador en modo headless (sin interfaz gráfica)
    driver = Selenium::WebDriver.for :edge, options: options
    wait = Selenium::WebDriver::Wait.new(timeout: 10) # Espera hasta 10 segundos
    driver.navigate.to url

    wait.until { driver.find_element(css: 'h3.cg__fw-400.mb-5.product-card__title.ng-star-inserted') }
    document = Nokogiri::HTML(driver.page_source)
    #puts document.css('div.products--grid > cgw-product-card.ng-star-inserted > a > div > cgw-item-image img.ng-lazyloading')
    #puts document.css('div.products--grid > cgw-product-card.ng-star-inserted > a > div > cgw-item-image img.ng-lazyloading').map { |img| img['src'] }
    product_data = document.css('div.products--grid > cgw-product-card.ng-star-inserted').map do |product|
    {
      title: product.at_css('h3.cg__fw-400.mb-5.product-card__title.ng-star-inserted')&.text,
      link: "https://compragamer.com#{product.at_css('a.cg__primary-card.product-card.responsive.vertical')&.[]('href')}",
      #image: product.at_css('div.products--grid > cgw-product-card.ng-star-inserted > a > div > cgw-item-image img.ng-lazyloading')&.[]('src'),
      image: "https://compragamer.com/assets/img/iconoCG.gif",
      price: product.at_css('span.txt_price')&.text&.gsub(/[^\d,]/, '')&.gsub(',', '.')&.to_f
    }
    end
    puts "Scraping Compragamer..."
    product_data.each do |product|
      existing_product = Product.find_or_initialize_by(name: product[:title])
      existing_product.update(
        description: "Sin descripción disponible.",
        price: product[:price],
        url: product[:link],
        img_url: product[:image],
        category_id: category_id
      )
    end
  end

end

#rails c
# la funcion scrape tiene valores por defecto
# ScrapeCompragamer.scrape