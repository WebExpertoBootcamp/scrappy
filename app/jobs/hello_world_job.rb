class HelloWorldJob
  include Sidekiq::Job

  def perform(*args)
    puts "Hello from inside a background job!"
    # ActionCable.server.broadcast("subscriptions_channel", { message: "Hello, it's me from the other side (wedsoquet)!" })
    ActionCable.server.broadcast("category_3", { message: "Hello, it's me from the other side (wedsoquet)!" })
  end
end

=begin

1. Importante activejob no es compatible con sidekiq, por lo que no se puede usar ApplicationJob
2. Se debe usar Sidekiq::Job y quitar queue_as :default
3. inicializar redis en wsl  "sudo service redis-server start" en local // en docker ya esta inicializado
4. En consola poner "bundle exec sidekiq" para iniciar el servidor de sidekiq y cargar los jobs (misma consola que se usa para rails s)

Ejemplo de como se veria un job con sidekiq
class MyFirstJob
  include Sidekiq::Job

  def perform(*args)
    # Do something
  end
end
=end
