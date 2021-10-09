class PokeImportService

  def api_connection(ressource: 'pokemon', limit: nil, offset: nil, id_or_name: nil)
    url =
      if id_or_name.nil?
        "#{ENV['BASE_URI']}/#{ressource}/?limit=#{limit}&offset=#{offset}"
      else
        "#{ENV['BASE_URI']}/#{ressource}/#{id_or_name}"
      end
    HTTParty.get(url).body
  end
end
