require_relative('display')
require_relative('player')
require_relative('secret_word')
require_relative('game_state')

class Game
  attr_reader :secret_word, :player, :guess_limit

  def initialize(saved_data = nil)
    if saved_data
      @secret_word = saved_data[:secret_word]
      @player = Player.new
      @player.turn = saved_data[:player_turn]
      @guess_limit = saved_data[:guess_limit]
      saved_data[:correct_guesses].each { |guess| @player.add_correct_guess(guess) }
      saved_data[:incorrect_guesses].each { |guess| @player.add_incorrect_guess(guess) }
    else
      @secret_word = SecretWord.new.secret_word.upcase
      @player = Player.new
      @guess_limit = 15
    end
    @display = Display.new(@secret_word.length)
    @guess = ''
    @game_over = false
  end

  def play
    until game_over?
      show_game_state
      input_guess
    end
    show_final_result
  end

  def input_guess
    puts "Type a letter and press Enter/Return"
    puts "If You Want to Save Your Game, Type 'save' "
    @guess = gets.chomp.upcase.to_s
    if @guess == 'SAVE'
      save_current_game
    elsif
      guess_handler
    end
  end

  def guess_handler
    if !valid_guess?
      puts "Invalid Guess! Please enter a single letter."
      return  # Return early without changing turn or guess limit
    elsif @player.has_guessed?(@guess)
      puts "You already guessed that letter!"
      return  # Return early without changing turn or guess limit
    else
      process_guess
      @player.turn += 1
      @guess_limit -= 1
    end
  end

  def valid_guess?
    ('A'..'Z').include?(@guess) && @guess.length == 1
  end

  def process_guess
    @secret_word.include?(@guess) ? @player.add_correct_guess(@guess) : @player.add_incorrect_guess(@guess)
  end

  def show_game_state
    @display.show_word(@secret_word, @player.correct_guesses)
    @display.show_guesses(@player.incorrect_guesses)
    @display.show_turns(@player.turn)
  end

  def game_over?
    guessed? || @guess_limit <= 0  # Game is over if word is guessed or out of guesses
  end

  def guessed?
    @secret_word.chars.all? { |letter| @player.correct_guesses.include?(letter) }
  end

  def winner?
    guessed? && @guess_limit > 0  # Win if word is guessed and still have guesses left
  end

  def show_final_result
    show_game_state
    if winner?
      puts "Congratulations! You won!"
    else
      puts "Game Over! The word was: #{@secret_word}"
    end
  end

  def save_current_game
    game_state = GameState.new(self)
    game_state.save
  end

end