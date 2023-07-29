# Coursera

The versions used are Ruby 3.2.2 and Rails 7.0.6.

The application is containerized using Docker for ease of development, testing, and deployment.

## Prerequisites

You need to have Docker and Docker Compose installed on your machine to run this application. If not, please follow the instructions in the official documentation to install them:

- [Docker](https://docs.docker.com/get-docker/)
- [Docker Compose](https://docs.docker.com/compose/install/)

## Getting Started

1. **Clone the repository:**

    ```
    git clone https://github.com/draganfabijan/coursera.git
    ```

2. **Navigate to the application directory:**

    ```
    cd coursera
    ```

3. **Build the Docker images:**

    ```
    docker-compose build
    ```
4. **Run database migrations:**

    ```
    docker-compose exec web rails db:create
    ```

5. **Run database migrations:**

    ```
    docker-compose exec web rails db:migrate
    ```
6. **Seed file:**

    ```
    docker-compose exec web rails db:seed
    ```
7. **For testing in dev create token**

    ```rb
    application = Doorkeeper::Application.create!(name: "MyApp", redirect_uri: "http://localhost")
    token = Doorkeeper::AccessToken.create!(application_id: application.id, resource_owner_id: nil, scopes: "").token
    ```
    this is only for testing otherwise use oauth endpoints.
    Set token in headers, for example:

    ```
    curl -H "Authorization: Bearer #{token}" http://localhost:3000/api/v1/verticals
    ```

## Running the application

To run the server:

```
docker-compose up
```

After running this command, the application should be accessible at `http://localhost:3000` or `http://0.0.0.0:3000`

## Running the tests

To run the test suite:

```
docker-compose exec web rspec
```

## Accessing the Rails console

To access the Rails console:

```
docker-compose exec web rails console
```

Please replace `web` with your service name if it's different in your `docker-compose.yml` file.




