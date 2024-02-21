require 'open-uri'
require 'json'
require "nokogiri"
LETTERS = ("A".."Z").to_a
class GamesController < ApplicationController
  def new
    @letters = generate_grid(10)
  end
  def score
    word = params[:word]
    grid = params[:grid].chars
    ## @result = valid_word(params[:word])
    goodword = victory(word.upcase, grid)
    valid = valid_word(word)
    if goodword
      @result = 'TODO'
      if valid
        @result = "Felicidades! Obtuviste #{word.length} puntos"
      else
        @result = "No existe la palabra #{word} en ingles"
      end
    else
      @result = "No puede generar la palabra #{word} con el grid: #{grid.join}"
    end
  end
  private
  def valid_word(attempt)
    # TODO: runs the game and return detailed hash of result (with `:score`, `:message` and `:time` keys)
    url = "https://wagon-dictionary.herokuapp.com/#{attempt}"
    html_file = URI.open(url).read
    user = JSON.parse(html_file)
    user['found']
  end
  def generate_grid(grid_size)
    # TODO: generate random grid of letters
    grid = []
    (0...grid_size).each do
      grid << LETTERS[rand(0...grid_size)]
    end
    grid
  end
  def victory(attempt, grid)
    # TODO: runs the game and return detailed hash of result (with `:score`, `:message` and `:time` keys)
    score = 0
    attempt.each_char do |s|
      if grid.include?(s)
        score += 1
        grid.delete_at(grid.index(s))
      else
        return false
      end
    end
    true
  end
end
