require 'rest-client'
require 'json'
require 'pry'

def get_characters
  people_api = 'http://www.swapi.co/api/people/'
  JSON.parse(RestClient.get(people_api))["results"]
end

def get_character_movies_from_api(character)
  if get_characters.none?{|hashobj|hashobj["name"]==character}
     puts "no such character"
     exit
   else
    film_array=get_characters.find{|hashobj|hashobj["name"]==character}["films"]
    film_array.map{ |film_api| JSON.parse(RestClient.get(film_api)) }
   end
end

def parse_character_movies(films_hash)
  puts films_hash.map{|film| film["title"]}.join(", ")
end

def show_character_movies(character)
  get_characters
  films_hash = get_character_movies_from_api(character)
  parse_character_movies(films_hash)
end
