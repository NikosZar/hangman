require 'yaml'

class GameState
  # def load
  # finds the directory
  # if empty, then no saved games
  # else lists with index the files in that directory
  # grab choice, choice -1 = the index
  # load_file the desired file
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

end