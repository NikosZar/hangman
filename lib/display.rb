require_relative 'secret_word'

class Display

  def initialize
    @word = SecretWord.new.secret_word
    @display_string = ":" * @word.length
  end

  def display_word
    @word
  end

  def display_string
    @display_string
  end

end

game = Display.new
puts game.display_word
puts game.display_string
