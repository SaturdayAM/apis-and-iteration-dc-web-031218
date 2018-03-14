require 'rest-client'
require 'json'
require 'pry'


def next_page(count)
  people_api = 'http://www.swapi.co/api/people/'
  current_page = JSON.parse(RestClient.get("#{people_api}?page=#{count}"))
  if current_page["next"]!= nil
    current_page["results"]
  else
    puts "No such character."
    do_it
  end
end

def get_character_movies_from_api(character)
  found = nil
  count = 1

  until found
    found = next_page(count).find{|hashobj|hashobj["name"]==character}
    count +=1
  end

  found["films"].map{ |film_api| JSON.parse(RestClient.get(film_api))} if found !=nil
end


def parse_character_movies(films_hash)
  puts "\n#{films_hash.map{|film| film["title"]}.join("\n").upcase}\n"
end

def show_character_movies(character)
  films_hash = get_character_movies_from_api(character)
  parse_character_movies(films_hash)
end
