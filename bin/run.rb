#!/usr/bin/env ruby

require_relative "../lib/api_communicator.rb"
require_relative "../lib/command_line_interface.rb"

welcome

character = nil

def do_it
  loop do
    character = get_character_from_user
    exit if character == "q"
    show_character_movies(character)
  end
end

do_it
