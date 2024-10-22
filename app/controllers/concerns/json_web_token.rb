require "jwt"

module JsonWebToken
  extend ActiveSupport::Concern
  #SECRET_KEY = ENV['SECRET_KEY_BASE']
  SECRET_KEY = 'supersercreto'

  def self.jwt_encode(payload, exp = 24.hours.from_now)
    payload[:exp] = exp.to_i
    JWT.encode(payload, SECRET_KEY)
  end

  def self.jwt_decode(token)
    decoded = JWT.decode(token, SECRET_KEY)[0]
    HashWithIndifferentAccess.new decoded
  end
end