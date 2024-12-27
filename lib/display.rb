require_relative 'secret_word'

class Display
  def initialize(word_length)
    @display_string = "_" * word_length  # Only needs word length, not the word itself
  end

  def show_word(secret_word, correct_guesses)
    # Update display string based on correct guesses
    display = secret_word.chars.map do |letter|
      correct_guesses.include?(letter) ? letter : ":"
    end
    puts display.join(" ")
  end

  def show_guesses(incorrect_guesses)
    puts "\nIncorrect guesses: #{incorrect_guesses.join(", ")}"
  end

  def show_turns(turn_count)
    puts "Turn: #{turn_count}"
  end
end

