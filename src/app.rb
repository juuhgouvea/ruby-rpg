require_relative 'modules/ui'
require_relative 'game'

GAME_OVER_OPTION = '7'

game = Game.new
selected_option = '0'

def render_menu
  UI.print "\t------------ Ruby RPG -------------", :blue
  UI.print "\t|     1. Create new character     |", :blue
  UI.print "\t|     2. Create new class         |", :blue
  UI.print "\t|     3. Train character          |", :blue
  UI.print "\t|     4. List all classes         |", :blue
  UI.print "\t|     5. List characters by class |", :blue
  UI.print "\t|     6. List characters by race  |", :blue
  UI.print "\t|     7. Game Over                |", :blue
  UI.print "\t-----------------------------------", :blue
end

def ask_for_race(message, game)
  race = nil

  while race.nil?
    race_name = UI.ask message
    race = game.find_race([race_name]).first

    UI.print "\tInvalid race. Try again!", :red if race.nil?
  end

  race
end

def ask_for_klass(message, game)
  klass = nil

  while klass.nil?
    klass_name = UI.ask message
    klass = game.find_klass([klass_name]).first
  end

  klass
end

until selected_option == GAME_OVER_OPTION
  render_menu
  selected_option = UI.ask "\t> ", :blue
  UI.clear

  case selected_option
  when '1'
    # if game.klasses.empty?
    #   UI.print "\tError: Create a class before continue.\n", :red
    #   next
    # end

    name = UI.ask "\tWhat's your character's name? (Enter to generate a random name) "
    age = UI.ask "\tWhat's your character's age? "
    race = ask_for_race("\tType your character's race (Must be 'Dwarf', 'Elf', 'Human' or 'Orc') ", game)
    klass_name = UI.ask "\tType your character's class "
    klass = game.find_klass([klass_name]).first

    UI.print "\tGenerating name...", :green if name.empty?

    character = game.create_new_character(name, age, race)

    UI.print "\tCharacter '#{character.name}' created.", :green
  when '2'
    UI.print "\tnew class created"
  when '3'
    UI.print "\tnew class acquired"
  when '4'
    UI.print "\tlasses list"
  when '5'
    UI.print "\tcharacters list by class"
  when '6'
    UI.print "\tcharacters list by race"
  when GAME_OVER_OPTION
    UI.print "\tGame over"
  else
    UI.print "\tinvalid option"
  end

  UI.ask "\n\t[Press Enter to continue]", :cyan
  UI.clear
end
