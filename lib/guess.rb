require_relative 'secret_word'

class Guess

  def initialize
    @guesses = []
    @guess = SecretWord.new.secret_word
  end

  def input_guess
    puts "Type a letter and press Enter/Return"
    @guess = gets.chomp.upcase.to_s
    guess_handler
  end

  def guess_handler
    valid_guess? ? @turn += 1 : raise("Invalid Guess, Enter a Letter")
  end

  def valid_guess?
    ('A'..'Z').include?(@guess) && @guess.length == 1
  end
end

guess = Guess.new
guess