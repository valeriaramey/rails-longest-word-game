require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }
  end

  def score
    @word = params[:word].upcase
    @grid = params[:letters]
    @included = included?(@word, @grid)
    filepath = open("https://wagon-dictionary.herokuapp.com/#{@word}")
    @word_result = JSON.parse(filepath.read)
    if @included
      if @word_result['found']
        @message = "Congratulations! #{@word} is a valid English word"
      else
        @message = "Sorry #{@word} is not a valid English word"
      end
    else
      @message = "Sorry, #{@word} can't be built out of the #{@grid}"
    end
  end

  private
  def included?(word, grid)
    word.chars.all? { |letter| word.count(letter) <= grid.count(letter) }
  end
end
