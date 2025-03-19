## Server

To run server, start Postgres and Redis. It's easiest to do with Docker.

    docker compose up --build --detach

Then start the Serverpod server.

    dart bin/main.dart

When finished, shut down Serverpod with `Ctrl-C`, then stop Postgres and Redis.

    docker compose stop


For detailed information about the **server implementation**, refer to the official **[Serverpod documentation](https://docs.serverpod.dev/)**.
