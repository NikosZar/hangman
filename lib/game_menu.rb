require_relative('game')

class GameMenu

  # Make initial Display Menu
  #   1. New Game
  #   2. Load Game
  #   3. Exit (optional)

  #Starts when the program is first run

  def initialize
    @choice = nil
  end

  def menu_display
    puts "#------HANGMAN-----#"
    puts "1. New Game"
    puts "2. Load Game"
    puts "3. Exit"
    print "\nEnter your choice (1-3): "
  end

  def get_choice
    @choice = gets.chomp
  end

  def valid_choice?
    ['1', '2', '3'].include?(@choice)
  end

  def choice_handler
    if valid_choice?
      if @choice == '1'
        game = Game.new
        game.play
      elsif @choice == '2'
        puts "Loading.."
      elsif @choice == '3'
        puts "Thanks for Playing!"
      end
    else
      puts "Invalid Choice"
    end
  end

  def start
    menu_display
    get_choice
    choice_handler
  end

end