### Set up docker

1. We need to install docker and docker-compose in out machine

2. We create a folder in which we create our amazing phoenix app

```sh
mkdir moon

cd moon

mix phx.new moon 
```

3. After creating the phoenix app, we already have the following structure `moon/moon`

We are gonna rename it to `src`, so we have moon/src

4. I create the Dockerfile in which I indicate which elixir version I am running, to copy my `src` file into the container

5. I create the `docker-compose` in wich I indicate to run the moon project my running the commands in the `scripts/entry_point.sh` file and to connect to the database

*Note:* We need to add execution permission to `entry_point.sh`:

```sh
chmod +x src/scripts/entrypoint.sh
```

6. In the file `config/dev.exs` I changed this line in order to indicate to connect to the host of the container

```elixir
  config :moon, Moon.Repo,
    username: "postgres",
    password: "postgres",
    hostname: System.get_env("PGHOST"),
    database: "moon_dev",
```

locate this part and update the ip from {127, 0, 0, 0} to {0, 0, 0, 0} like this.

```elixir
  config :moon, MoonWeb.Endpoint,
  # Binding to loopback ipv4 address prevents access from other machines.
  # Change to `ip: {0, 0, 0, 0}` to allow access from other machines.
    http: [ip: {0, 0, 0, 0}, port: 4000],
```

7. We can run our project 

```sh
docker-compose up --build
```

8. If the need to get into the container, we can run:

```sh
docker container run -it --rm -v "$(pwd)/src:/app" -w /app elixir:1.13 /bin/bash
```



Common errors:

- Sometimes an error occurs at trying to run the project related to `gettext` dependency

We need to remove the `gettext` from the mix file: 

```elixir
compilers: [] ++ Mix.compilers(),
```

