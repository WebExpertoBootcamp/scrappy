class HelloWorldJob < ApplicationJob
  queue_as :default

  def perform(*args)
    puts "Hello from inside a background job!"
  end
end
