require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character)
  #make the web request
  all_characters = RestClient.get('http://www.swapi.co/api/people/')
  character_hash = JSON.parse(all_characters)
  character_arr = character_hash["results"]

  # iterate over the character hash to find the collection of `films` for the given
  #   `character`
  # collect those film API urls, make a web request to each URL to get the info
  #  for that film
  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `parse_character_movies`
  #  and that method will do some nice presentation stuff: puts out a list
  #  of movies by title. play around with puts out other info about a given film.


  film_arr = character_arr.detect{|hash_obj| hash_obj["name"] == character}
  if film_arr != nil
    film_arr = film_arr["films"]
  else 
    puts "Invalid character input"
    exit
  end

  film_details = []

  #character_arr.each do |hash_obj|
  #  if hash_obj["name"] == character 
  #    film_arr = hash_obj["films"]
  #  end
  #end

  film_arr.each do |url|
    temp = JSON.parse(RestClient.get(url))
    film_details.push(temp)
  end  
  film_details
end


def parse_character_movies(films_hash)
  # some iteration magic and puts out the movies in a nice list
  to_return = films_hash.map do |hash_obj| 
    hash_obj["title"]
  end

end

def show_character_movies(character)
  films_hash = get_character_movies_from_api(character)
  titles = parse_character_movies(films_hash)
  puts titles.join(", ")
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
