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