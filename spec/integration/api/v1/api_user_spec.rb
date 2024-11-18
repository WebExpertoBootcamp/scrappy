require 'swagger_helper'

RSpec.describe 'API de Usuarios', type: :request do

  # Endpoint: POST /auth/register
  path '/auth/register' do
    post('Registrar usuario') do
      tags 'Autenticación'
      consumes 'application/json'
      produces 'application/json'

      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          email: { type: :string },
          password: { type: :string },
          password_confirmation: { type: :string },
          category_ids: { type: :array, items: { type: :integer } }
        },
        required: %w[email password password_confirmation]
      }

      response(201, 'Usuario creado') do
        schema type: :object,
               properties: {
                 token: { type: :string },
                 user: { '$ref': '#/components/schemas/User' },
                 subscribed_categories: { type: :array, items: { '$ref': '#/components/schemas/Category' } }
               }

        run_test!
      end

      response(422, 'Error de validación') do
        schema type: :object,
               properties: {
                 errors: { type: :array, items: { type: :string } }
               }

        run_test!
      end
    end
  end

  # Endpoint: POST /auth/login
  path '/auth/login' do
    post('Iniciar sesión') do
      tags 'Autenticación'
      consumes 'application/json'
      produces 'application/json'

      parameter name: :credentials, in: :body, schema: {
        type: :object,
        properties: {
          email: { type: :string },
          password: { type: :string }
        },
        required: %w[email password]
      }

      response(200, 'Sesión iniciada') do
        schema type: :object,
               properties: {
                 token: { type: :string },
                 user: { '$ref': '#/components/schemas/User' }
               }

        run_test!
      end

      response(401, 'Credenciales inválidas') do
        schema type: :object,
               properties: {
                 error: { type: :string }
               }

        run_test!
      end
    end
  end

  # Endpoint: PUT /auth/subscription
  path '/auth/subscription' do
    put('Actualizar suscripción') do
      tags 'Suscripciones'
      consumes 'application/json'
      produces 'application/json'

      parameter name: :Authorization, in: :header, type: :string, description: 'Token JWT del usuario'
      parameter name: :categories, in: :body, schema: {
        type: :object,
        properties: {
          category_ids: { type: :array, items: { type: :integer } }
        },
        required: ['category_ids']
      }

      response(200, 'Suscripción actualizada') do
        schema type: :object,
               properties: {
                 message: { type: :string },
                 subscribed_categories: { type: :array, items: { '$ref': '#/components/schemas/Category' } }
               }

        run_test!
      end

      response(400, 'Categorías no proporcionadas') do
        schema type: :object,
               properties: {
                 error: { type: :string }
               }

        run_test!
      end

      response(401, 'Usuario no autenticado') do
        schema type: :object,
               properties: {
                 error: { type: :string }
               }

        run_test!
      end
    end
  end

  # Endpoint: DELETE /auth/subscription
  path '/auth/subscription' do
    delete('Eliminar suscripción') do
      tags 'Suscripciones'
      consumes 'application/json'
      produces 'application/json'

      parameter name: :Authorization, in: :header, type: :string, description: 'Token JWT del usuario'
      parameter name: :categories, in: :body, schema: {
        type: :object,
        properties: {
          category_ids: { type: :array, items: { type: :integer } }
        },
        required: ['category_ids']
      }

      response(200, 'Categorías eliminadas con éxito') do
        schema type: :object,
               properties: {
                 message: { type: :string },
                 remaining_categories: { type: :array, items: { '$ref': '#/components/schemas/Category' } }
               }

        run_test!
      end

      response(404, 'Categorías no encontradas') do
        schema type: :object,
               properties: {
                 error: { type: :string }
               }

        run_test!
      end

      response(401, 'Usuario no autenticado') do
        schema type: :object,
               properties: {
                 error: { type: :string }
               }

        run_test!
      end
    end
  end

  # Endpoint: GET /auth/mysubscriptions
  path '/auth/mysubscriptions' do
    get('Obtener suscripciones') do
      tags 'Suscripciones'
      produces 'application/json'

      parameter name: :Authorization, in: :header, type: :string, description: 'Token JWT del usuario'

      response(200, 'Suscripciones obtenidas') do
        schema type: :object,
               properties: {
                 message: { type: :string },
                 subscriptions: { type: :array, items: { '$ref': '#/components/schemas/Category' } }
               }

        run_test!
      end

      response(401, 'Usuario no autenticado') do
        schema type: :object,
               properties: {
                 error: { type: :string }
               }

        run_test!
      end
    end
  end

  # Endpoint: GET /auth/get_categories
  path '/auth/get_categories' do
    get('Listar categorías') do
      tags 'Categorías'
      produces 'application/json'

      response(200, 'Categorías listadas') do
        schema type: :array, items: { '$ref': '#/components/schemas/Category' }
        run_test!
      end
    end
  end
end
