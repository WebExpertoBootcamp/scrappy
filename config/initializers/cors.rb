# config/initializers/cors.rb

Rails.application.config.middleware.insert_before 0, Rack::Cors do
    allow do
      origins '*'  # Permitir todas las orígenes
      resource '*', # Permitir cualquier recurso
        headers: :any,  # Permitir cualquier encabezado
        methods: [:get, :post, :patch, :put]  # Métodos permitidos
    end
  end
  