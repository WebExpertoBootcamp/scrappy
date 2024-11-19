require 'swagger_helper'

RSpec.describe 'API de Usuarios', type: :request do

  # Endpoint: POST /auth/register
  path '/api/v1/auth/register' do
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
      let(:user) do
        {
          email: 'test@example.com',
          password: 'password123',
          password_confirmation: 'password123'
        }
      end

      response(201, 'Created') do
        schema type: :object,
          properties: {
            token: { type: :string },
            user: {
              type: :object,
              properties: {
                id: { type: :integer },
                email: { type: :string },
                created_at: { type: :string, format: :date_time },
                updated_at: { type: :string, format: :date_time },
                role: { type: :string }
              }
            }
          }

        run_test!
      end

      response(422, 'Error de validación') do
        schema type: :object,
          properties: {
            errors: { type: :array, items: { type: :string } }
          }
        let(:user) do
          {
            email: 'test@example.com',
            password: 'password123',
            password_confirmation: 'password1234'
          }
        end

        run_test!
      end 

    end
  end
 
  # Endpoint: POST /auth/login
  path '/api/v1/auth/login' do
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
      let!(:user) { create(:user, email: 'test@example.com', password: 'password123', role: 'user') }
      let(:credentials) do
        {
          email: 'test@example.com',
          password: 'password123'
        }
      end

      response(200, 'Sesión iniciada') do
        schema type: :object,
              properties: {
                token: { type: :string },
                user: {
                  type: :object,
                  properties: {
                    id: { type: :integer },
                    email: { type: :string },
                    created_at: { type: :string, format: :date_time },
                    updated_at: { type: :string, format: :date_time },
                    role: { type: :string }
                    }
                }
              }

        run_test!
      end

      response(401, 'Credenciales inválidas') do
        schema type: :object,
          properties: {
            error: { type: :string }
          }
        let(:credentials) do
          {
            email: 'wrong@example.com', 
            password: 'wrongpassword'   
          }
        end

        run_test!
      end 

    end
  end

  # Endpoint: GET /auth/list_categories
  path '/api/v1/auth/list_categories' do
    get('Listar categorías') do
      tags 'Categorías'
      produces 'application/json'
      # Parámetro Authorization para el token JWT
      parameter name: :Authorization, in: :header, type: :string, description: 'Token JWT del usuario'

      let!(:user) { create(:user, email: 'test@example.com', password: 'password123', role: 'user') }
      # Simula el inicio de sesión para obtener el token JWT
      let(:credentials) do
        {
          email: 'test@example.com',
          password: 'password123'
        }
      end

      let(:Authorization) { "Bearer #{authenticate_user_and_get_token(credentials)}" }

      # Función que autentica al usuario y obtiene el token JWT
      def authenticate_user_and_get_token(credentials)
        post '/api/v1/auth/login', params: credentials.to_json, headers: { 'Content-Type' => 'application/json' }
        json_response = JSON.parse(response.body)
        json_response['token']
      end

      response(200, 'Categorías listadas') do
        schema type: :array, items: {
          type: :object,
          properties: {
            id: { type: :integer },
            name: { type: :string },
            description: { type: :string },
            scrappers: { type: :array, items: { type: :string } }
          },
          required: ['id', 'name', 'description', 'scrappers']
        }
        run_test!
      end
    end
  end


=begin
  # Endpoint: PUT /auth/subscription
  path '/api/v1/auth/subscription' do
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


    let!(:user) { create(:user, email: 'test@example.com', password: 'password123', role: 'user') }
    # Simula el inicio de sesión para obtener el token JWT
    let(:credentials) do
      {
        email: 'test@example.com',
        password: 'password123'
      }
    end

    let(:Authorization) { "Bearer #{authenticate_user_and_get_token(credentials)}" }

    # Función que autentica al usuario y obtiene el token JWT
    def authenticate_user_and_get_token(credentials)
      post '/api/v1/auth/login', params: credentials.to_json, headers: { 'Content-Type' => 'application/json' }
      json_response = JSON.parse(response.body)
      json_response['token']
    end

    let!(:categories) do
      [
        create(:category, id: 1, name: 'Category 1', description: 'Description 1'),
        create(:category, id: 2, name: 'Category 2', description: 'Description 2'),
        create(:category, id: 3, name: 'Category 3', description: 'Description 3')
      ]
    end
    let(:categories) do
      {
        category_ids: [1, 2, 3]
      }
    end

    response(200, 'Suscripción actualizada') do
      schema type: :object,
      properties: {
        message: { type: :string, example: 'Suscripción actualizada con éxito' },
        subscribed_categories: {
          type: :array,
          items: {
            type: :object,
            properties: {
              id: { type: :integer },
              name: { type: :string },
              description: { type: :string },
              created_at: { type: :string, format: :date_time },
              updated_at: { type: :string, format: :date_time }
            }
          }
        }
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

  
=end
end
