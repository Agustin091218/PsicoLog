# psicolog

Quick guide to run this project with Docker (development environment).

## Requirements

- Docker Desktop (or Docker Engine + Compose plugin)

## Initial setup

1. Clone the repository.
2. Copy the committed environment template:

```bash
cp .env.example .env
```

## Start the project

```bash
docker compose up -d --build --remove-orphans
```

The app will be available at:

- http://localhost:3000

## Container Startup Flow

On every `docker compose up`, startup works like this:

1. The `db` service starts and becomes healthy using `pg_isready`.
2. The `web` service waits for `db` health (`depends_on: condition: service_healthy`).
3. The container entrypoint (`/rails/bin/docker-entrypoint`) runs before the Rails command.
4. If the command is `./bin/rails server`, the entrypoint runs `./bin/rails db:prepare`.
5. `db:prepare` creates the database if needed and runs pending migrations.
6. Control is handed off to the Rails server process.

This means migrations are applied automatically on startup. Adding a new migration and running `docker compose up` is usually enough.

> Note: only the `web` service uses `bin/docker-entrypoint`. The `db` service keeps the official PostgreSQL image entrypoint.

## Hot Reload

The volume `.:/rails` mounts your local source code into the container.
In development, Rails uses Zeitwerk, so most code and view changes are picked up on the next request without restarting the server.

| Resource | Behavior |
|---|---|
| Models, Controllers, Services | Reloaded on each request |
| Views (`.html.erb`) | Reloaded on each request |
| `config/routes.rb` | Reloaded on each request |
| `config/application.rb` | Requires container restart |
| `config/database.yml` | Requires container restart |
| New gems in `Gemfile` | Requires rebuild (`docker compose up -d --build`) |

## Useful commands

```bash
# show service status
docker compose ps

# show logs
docker compose logs -f web
docker compose logs -f db

# open Rails console
docker compose exec web ./bin/rails console

# run a Rails task
docker compose exec web ./bin/rails db:migrate

# stop containers
docker compose down
```

## CI

GitHub Actions uses `.env.example` through `APP_ENV_FILE=.env.example` for the Docker Compose smoke check, so keep that file aligned with the variables the stack needs to boot.

## Orphan container cleanup

If you see an `orphan containers` warning:

```bash
docker compose down --remove-orphans
```
