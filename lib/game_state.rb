require 'yaml'

class GameState
  def initialize(game)
    @incorrect_guesses = game.player.incorrect_guesses
    @correct_guesses = game.player.correct_guesses
    @turn = game.player.turn
    @secret_word = game.secret_word
    @guess_limit = game.guess_limit
  end

  def save
    make_save_directory
    filename = make_filename

    File.open(filename, 'w') { |file| file.write(YAML.dump(game_data)) }
    puts "Game saved as #{filename}"
  end

  def game_data
    {
      secret_word: @secret_word,
      player_turn: @turn,
      guess_limit: @guess_limit,
      incorrect_guesses: @incorrect_guesses,
      correct_guesses: @correct_guesses
    }
  end

  def make_save_directory
    Dir.mkdir('saved_games') unless Dir.exist?('saved_games')
  end

  def make_filename
    "saved_games/game_#{Time.now.strftime('%Y%m%d_%H%M%S')}.yml"
  end

  def self.load
    saved_files = Dir['saved_games/*.yml']
    if saved_files.empty?
      puts "\nThere are no Saved Games"
      puts "\n"
      menu = GameMenu.new
      menu.start
      return nil
    end

    #display available saved games
    puts "\nSaved Game"
    saved_files.each_with_index do |file, index|
      puts "#{index+1}. #{File.basename(file)} "
    end

    # Get user choice
    print "\nChoose a game to load (1-#{saved_files.length}): "
    choice = gets.chomp.to_i

    if choice.between?(1, saved_files.length)
      YAML.load_file(saved_files[choice - 1])
    else
      puts "Invalid Choice!"
      nil
    end
  end

end