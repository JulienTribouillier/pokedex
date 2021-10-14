
# Pokedex

This rails application, allows you to consume the https://pokeapi.co API, store data in databases, and return views in JSON and HTML


## Run Locally

Clone the project

```bash
  git clone git@github.com:Popikadir/pokedex.git
```

Go to the project directory

```bash
  cd pokedex
```

Install dependencies

```bash
  bundle install
  yarn install
```

run migration

```bash
  rails db:create && rails db:migrate
```
You need to create a .env file in the root of the application 

```bash
  cd pokedex
  touch .env
```
Copy/paste the api URI variable in **.env** file
```ruby
  BASE_URI="https://pokeapi.co/api/v2/"
```

Start the server

```bash
  rails server
```

  
## Usage/Examples

 You can run seed to have 20 pokemons in database

```bash
rails db:seed

```

If you whant to import all pokemons, run the following command 

```bash
rails console

```
```shell
>  pokeapi = ImportPokemonsJob.new
>  pokeapi.perform(1200)

```

This operation take time to end
## API Reference

#### Get all pokemons

```http
  GET api/v1/pokemons
```

#### Get pokemon

```http
  GET /api/v1/{id}
```

| Parameter | Type     | Description                       |
| :-------- | :------- | :-------------------------------- |
| `id`      | `string` | **Required**. Id of pokemon to fetch |



  
## Running Tests

To run tests, run the following command

```bash
  rspec
```

  
## Tech Stack

**Client:** Json, Bootstrap

**Server:** Ruby 3.0.0, Ruby on Rails 6.1.4.1

  
## Environment Variables

To run this project, you will need to add the following environment variables to your .env file

`BASE_URI="https://pokeapi.co/api/v2/"`


  
## Demo

You can see a running app [here](https://pokedex-ror-production.herokuapp.com/)

Or you can go directly to API [here](https://pokedex-ror-production.herokuapp.com//api/v1/pokemons)

