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
  race_name = ''

  until game.race_exists?(race_name)
    race_name = UI.ask message
    race = game.find_race([race_name]).first

    UI.print "\tInvalid race. Try again!", :red if race.nil?
  end

  race
end

def ask_for_klass(message, game)
  klass_name = ''

  until game.klass_exists?(klass_name)
    klass_name = UI.ask message
    klass = game.find_klass([klass_name]).first

    UI.print "\tInvalid class. Try again!", :red if klass.nil?
  end

  klass
end

def ask_for_character(message, game)
  character_name = ''

  until game.character_exists?(character_name)
    character_name = UI.ask message
    character = game.find_klass([character_name]).first

    UI.print "\tCharacter doesn't exist. Try again!", :red if character.nil?
  end

  character
end

until selected_option == GAME_OVER_OPTION
  render_menu
  selected_option = UI.ask "\t> ", :blue
  UI.clear

  available_klasses = game.klasses.map { |klass| klass.name.strip }

  case selected_option
  when '1'
    if game.klasses.empty?
      UI.print "\tError: Create a class before continue.\n", :red
      next
    end

    name = ''
    character_exists = true
    while character_exists
      name = UI.ask "\tWhat's your character's name? (Enter to generate a random name) "
      break if name.empty?

      character_exists = game.character_exists?(name)

      UI.print "\tCharacter '#{name}' already exists.", :red if character_exists
    end

    age = UI.ask "\tWhat's your character's age? "
    race = ask_for_race("\tType your character's race (Must be 'Dwarf', 'Elf', 'Human' or 'Orc') ", game)

    UI.print "\tType your character's class [#{available_klasses.join(', ')}]", :yellow
    klass = ask_for_klass("\t> ", game)

    UI.print "\tGenerating name...", :green if name.empty?

    character = game.create_new_character(name, age, race, klass)

    UI.print "\tCharacter '#{character.name}' created.", :green
  when '2'
    name = ''
    klass_exists = true

    while klass_exists || name.empty?
      name = UI.ask "\tWhat's the class name? "
      klass_exists = game.klass_exists?(name)

      UI.print "\tThe class name must be provided.", :red if name.empty?
      UI.print "\tClass '#{name}' already exists.", :red if klass_exists
    end

    UI.print "\tType the abilities for '#{name}' class? (Separeted by comma, ex: A, B, ...)", :yellow
    abilities = UI.ask "\t> "
    abilities = abilities.split(',').map(&:strip)

    life = UI.ask "\tWhat's the life for '#{name}' class? "
    attack = UI.ask "\tWhat's the attack for '#{name}' class? "
    defense = UI.ask "\tWhat's the defense for '#{name}' class? "
    inteligence = UI.ask "\tWhat's the inteligence for '#{name}' class? "
    force = UI.ask "\tWhat's the force for '#{name}' class? "

    modifiers = {
      life: life.to_i,
      attack: attack.to_i,
      defense: defense.to_i,
      inteligence: inteligence.to_i,
      force: force.to_i
    }

    klass = game.create_new_klass(name, abilities, modifiers)
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
