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
    git clone https://github.com/draganfabijan/airfinity.git
    ```

2. **Navigate to the application directory:**

    ```
    cd airfinity
    ```

3. **Build the Docker images:**

    ```
    docker-compose build
    ```

4. **Run database migrations:**

    ```
    docker-compose exec web rails db:migrate
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

## Contributing

If you want to contribute to this project, please create a new branch, make your changes, and create a pull request.

Enjoy coding!