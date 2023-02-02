FROM elixir:1.13

RUN apt-get update -y
RUN apt-get install -y postgresql-client
RUN apt-get install -y inotify-tools

# Install Hex package manager.
RUN mix local.hex --force
RUN mix local.rebar --force

# Create app directory and copy the Elixir projects into it.
RUN mkdir /app
COPY ./src /app
WORKDIR /app