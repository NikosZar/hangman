#player can make guesses
# has turn counts
# has incorrect guesses
# has correct guesses
# manages turns and guesses

class Player
  attr_accessor :turn
  attr_reader :correct_guesses, :incorrect_guesses

  def initialize
    @turn = 1
    @correct_guesses = []
    @incorrect_guesses = []
  end

  def add_correct_guess(letter)
    @correct_guesses << letter
  end

  def add_incorrect_guess(letter)
    @incorrect_guesses << letter
  end

  def has_guessed?(letter)
    @correct_guesses.include?(letter) || @incorrect_guesses.include?(letter)
  end

end