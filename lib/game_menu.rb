require_relative('game')

class GameMenu
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
        if (saved_data = GameState.load)
          game = Game.new(saved_data)
          game.play
        else
          puts "\nStarting new game instead..."
          game = Game.new
          game.play
        end
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