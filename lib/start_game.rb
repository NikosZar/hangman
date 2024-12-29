require_relative('game_menu')

class StartGame

  def self.start_game
    menu = GameMenu.new
    menu.start
  end
end

StartGame.start_game