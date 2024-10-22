require 'selenium-webdriver'

class ScrapeProduct
  def self.scrape_and_save_product(url)
    # Configura el driver de Selenium
    options = Selenium::WebDriver::Chrome::Options.new
    options.add_argument('--headless') # Ejecuta el navegador sin abrir la ventana

    # Inicializa el navegador (Chrome en este caso)
    driver = Selenium::WebDriver.for :chrome, options: options

    # Visita la página que contiene los productos
    driver.get(url)

    # Espera a que los productos sean cargados mediante JS
    sleep(5) # Aumenta el tiempo si es necesario

    # Extrae los productos después de que el JS se haya ejecutado
    products = driver.find_elements(css: '.card')

    products.each do |product_element|
      name = product_element.find_element(css: 'h5.card-title').text
      price = product_element.find_element(css: 'p.price-text').text
      puts "Producto: #{name}, Precio: #{price}"

      # Aquí puedes guardar los productos en la base de datos
    end

    # Cierra el navegador
    driver.quit
  end
end
