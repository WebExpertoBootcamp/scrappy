# Scrappy API

## **Overview** 
Esta aplicación web, desarrollada con Ruby on Rails 7, permite a los usuarios suscribirse a notificaciones en tiempo real sobre oportunidades de compra (descuentos o rebajas) en productos o servicios de su interés.

## **Instalacion** 
### Requisitos
- Docker
- Git

### 1. Clonar el repositorio
```bash
git clone https://github.com/WebExpertoBootcamp/scrappy.git
cd scrappy
```
### 2. Construir y levantar contenedores de Docker
```bash
docker-compose up --build
```
Nota: la bandera `--build` es solo necesaria la primera vez que se ejecuta el comando.

### 3. Ejecutar el seed para crear datos de usuarios
```bash
docker ps
docker exec -it scrappy-rails-1 bash
rails db:seed
```

### 4. Acceder a la aplicación
- La aplicación estará disponible en `http://localhost:3000`

### 5. Detener los contenedores
Para detener los contenedores de Docker, ejecutar el siguiente comando:
```bash
docker-compose down
```

## Equipo Desarrollador

Nos enorgullece presentar a nuestro increíble equipo de desarrolladores que hicieron posible el proyecto ***SCRAPPY**:


|                                                                                                                               ![Foto](https://github.com/juliansandoval.png)                                                                                                                               |                                                                                                                                 ![Foto](https://github.com/Noelia-Ruiz.png)                                                                                                                                  |
| :---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------: | :-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------: |
|                                                                                                                                             **Julian Sandoval**                                                                                                                                             |                                                                                                                                            **Noelia Ruiz**                                                                                                                                             |
|                                                                                                                                                                                                                                                                                                             |
| [![LinkedIn](https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/alefernandez88/) [![GitHub](https://img.shields.io/badge/GitHub-181717?style=for-the-badge&logo=github&logoColor=white)](https://github.com/Susana-Sandoval) | [![LinkedIn](https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/alefernandez88/) [![GitHub](https://img.shields.io/badge/GitHub-181717?style=for-the-badge&logo=github&logoColor=white)](https://github.com/usuario6) |

**-**
|                                                                                                                               ![Foto](https://github.com/alefernandez88.png)                                                                                                                               |                                                                                                                                 ![Foto](https://github.com/Matijasevic-Emer.png)                                                                                                                                  |
| :---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------: | :-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------: |
|                                                                                                                                             **Ale Fernandez**                                                                                                                                             |                                                                                                                                            **Emer Matijasevic**                                                                                                                                             |
|                                                                                                                                                                                                                                                                                                             |
| [![LinkedIn](https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/alefernandez88/) [![GitHub](https://img.shields.io/badge/GitHub-181717?style=for-the-badge&logo=github&logoColor=white)](https://github.com/alefernandez88) | [![LinkedIn](https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/emerson-matijasevic/) [![GitHub](https://img.shields.io/badge/GitHub-181717?style=for-the-badge&logo=github&logoColor=white)](https://github.com/Matijasevic-Emer) |




## Tecnologías Utilizadas

El proyecto "Scrappy API" utiliza las siguientes tecnologías de frontend:

| Tecnología                                                                                                                  | Descripción                                                                            |
| --------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------- |
| ![Ror](https://img.shields.io/badge/Ruby_on_Rails-D30001?style=flat&logo=ruby-on-rails&logoColor=white)                             | **Ruby on Rails**: Framework para el desarrollo de la aplicación web y la API.                         |
| ![Postgresql](https://img.shields.io/badge/PostgreSQL-4169E1?style=flat&logo=postgresql&logoColor=white)                          | **Postgresql**: Base de datos para almacenar la información del sistema.         |
| ![JWT](https://img.shields.io/gem/v/jwt?label=JWT) | **JWT**: Para la autenticación de usuarios en la API. |
| ![Sidekiq](https://img.shields.io/gem/v/sentry-sidekiq?label=sentry-sidekiq)     | **Sidekiq**: Procesador de jobs en segundo plano para ejecutar el scraping de forma asíncrona.                 |


## 🚀 Gestión del Proyecto

![Jira](https://shields.io/badge/simple__diarizer-Trello-blue?logo=Trello&style=flat)

## 🚀 Comunicación

![Discord](https://img.shields.io/badge/Discord%20-%20pr?style=for-the-badge&logo=discord&logoColor=%23ffffff&labelColor=%235865F2&color=%235865F2)
![Whatsapp](https://img.shields.io/badge/Whatsapp%20-%20pr?style=for-the-badge&logo=whatsapp&logoColor=%23ffffff&labelColor=%2325D366&color=%2325D366)
![Google Meet](https://img.shields.io/badge/Google%20meet%20-%20pr?style=for-the-badge&logo=googlemeet&logoColor=%23ffffff&labelColor=%2300897B&color=%2300897B)

## 🚀 [DOCUMENTACIÓN API](https://docs.google.com/document/d/1MLO4YF7hXZV0tJCIdfEPT3ZoXsBT81cMAR6gOR737SY/edit?tab=t.0)
