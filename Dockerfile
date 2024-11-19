# Usa la imagen base de Ruby 3
FROM ruby:3


# Actualiza los repositorios de paquetes y luego instala las dependencias necesarias
RUN apt-get update && apt-get install -y \
  nodejs \
  curl \
  postgresql-client \
  yarn


# Instala Bundler
RUN gem install bundler


# Instala Rails
RUN gem install rails

# Copia los archivos del proyecto en el contenedor
WORKDIR /app
COPY . .

# Instalar las gemas del proyecto
RUN bundle install

# Exponer el puerto 3000 para el servidor Rails
EXPOSE 3000

# Comando por defecto para preparar la base de datos y arrancar el servidor de Rails
#CMD ["sh", "-c", "bundle exec rails db:create && bundle exec rails db:migrate && bundle exec sidekiq & bundle exec rails server -b '0.0.0.0'"]
