class PokeImportService

  def fetch_pokemon_list(limit = 10, offset = 0)
    fetch_resource('pokemon', limit: limit, offset: offset)
  end

  def fetch_one_pokemon(id_or_name)
    fetch_resource('pokemon', id_or_name: id_or_name)
  end

  def fetch_one_type(id_or_name)
    fetch_resource('type', id_or_name: id_or_name)
  end

  def fetch_type_list(limit = 25, offset = 0)
    fetch_resource('type', limit: limit, offset: offset)
  end

  def fetch_one_ability(id_or_name)
    fetch_resource('ability', id_or_name: id_or_name)
  end

  def fetch_ability_list(limit = -1, offset = 0)
    fetch_resource('ability', limit: limit, offset: offset)
  end

  def fetch_resource(resource_name, id_or_name: nil, limit: 10, offset: 0)
    request_url = "#{ENV['BASE_URI']}/#{resource_name}"
    request_url +=
      if id_or_name
        "/#{id_or_name}"
        # this url is made to have specifics request, like one pokemon or one type
      else
        "?limit=#{limit}&offset=#{offset}"
        # this part of the url set the limit of resources we want to fetch
      end
    response = HTTParty.get(request_url)
    JSON.parse(response.body, object_class: OpenStruct)
    # it seems much more easier to work with OpenStruct object
  end

  def import_pokemon_list(limit = 10, offset = 0)
    # change the limit to -1 to have all pokemons in database, better run background job
    import_fetched_resources('pokemon', limit: limit, offset: offset)
  end

  def import_type_list(limit = 20, offset = 0)
    import_fetched_resources('type', limit: limit, offset: offset)
  end

  def import_ability_list(limit = -1, offset = 0)
    import_fetched_resources('ability', limit: limit, offset: offset)
  end

  def import_fetched_resources(resource_name, limit: 10, offset: 0)
    fetched_resource = send("fetch_#{resource_name}_list", limit, offset)
    fetched_resource.results.each do |p|
      send("import_one_#{resource_name}", p.name)
    end
  end

  def import_one_pokemon(id_or_name)
    fetched_pokemon = fetch_one_pokemon(id_or_name)
    pokemon = Pokemon.find_by(name: fetched_pokemon.name) || Pokemon.new
    pokemon.tap do |p|
      p.name = fetched_pokemon.name
      p.num = fetched_pokemon.id
      p.sprite = fetched_pokemon.sprites.front_default
      p.height = fetched_pokemon.height
      p.weight = fetched_pokemon.weight
      p.types = get_types(fetched_pokemon.types)
      p.abilities = get_abilities(fetched_pokemon.abilities)
    end
    pokemon.save
  end

  def import_one_type(id_or_name)
    fetched_type = fetch_one_type(id_or_name)
    Type.find_or_create_by(name: fetched_type.name)
  end

  def get_types(fetch_types)
    fetch_types.map { |t| Type.find_or_create_by!(name: t.type.name) }
  end

  def import_one_ability(id_or_name)
    fetched_ability = fetch_one_ability(id_or_name)
    Ability.find_or_create_by(name: fetched_ability.name)
  end

  def get_abilities(fetch_abilities)
    fetch_abilities.map { |t| Ability.find_or_create_by(name: t.ability.name) }
  end
end
