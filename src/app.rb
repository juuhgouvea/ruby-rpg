require_relative 'modules/ui'
require_relative 'game'

GAME_OVER_OPTION = '7'

game = Game.new(
  [
    Klass.new('Builder', ['Build houses'], {force: 1, inteligence: 1, life: -2}),
    Klass.new('Blacksmith', ['Create swords and armors'], {force: 2, attack: 1}),
    Klass.new('Healer', ['Heal other units'], {defense: 3, attack: -1, inteligence: 3}),
    Klass.new('Warrior', ['Attack, Defend'], {defense: 2, attack: 3, force: 2})
  ]
)
selected_option = '0'

def render_menu
  UI.print "------------ Ruby RPG -------------", :blue
  UI.print "|     1. Create new character     |", :blue
  UI.print "|     2. Create new class         |", :blue
  UI.print "|     3. Train character          |", :blue
  UI.print "|     4. List all classes         |", :blue
  UI.print "|     5. List characters by race  |", :blue
  UI.print "|     6. List characters by class |", :blue
  UI.print "|     7. Game Over                |", :blue
  UI.print "-----------------------------------", :blue
end

def goodbye
  UI.print "------------ Game Over ------------", :red
  UI.print "         Thanks for playing        ", :red
  UI.print "-----------------------------------", :red
end

def ask_for_race(message, game)
  race_name = ''

  until game.race_exists?(race_name)
    race_name = UI.ask message
    race = game.find_race([race_name]).first

    UI.print "Invalid race. Try again!", :red if race.nil?
  end

  race
end

def ask_for_klass(message, game)
  klass_name = ''

  until game.klass_exists?(klass_name)
    klass_name = UI.ask message
    klass = game.find_klass([klass_name]).first

    UI.print "Invalid class. Try again!", :red if klass.nil?
  end

  klass
end

def ask_for_character(message, game)
  character_name = ''

  until game.character_exists?(character_name)
    character_name = UI.ask message
    character = game.find_character([character_name.downcase.strip]).first

    UI.print "Character doesn't exist. Try again!", :red if character.nil?
  end

  character
end

until selected_option == GAME_OVER_OPTION
  render_menu
  selected_option = UI.ask "> ", :blue
  UI.clear

  available_klasses = game.klasses.map { |klass| klass.name.strip }
  available_characters = game.characters.map { |character| character.name.strip }

  case selected_option
  when '1'
    if game.klasses.empty?
      UI.print "Error: Create a class before continue.\n", :red
      next
    end

    name = ''
    character_exists = true
    while character_exists
      name = UI.ask "What's your character's name? (Enter to generate a random name) "
      break if name.empty?

      character_exists = game.character_exists?(name)

      UI.print "Character '#{name}' already exists.", :red if character_exists
    end

    age = UI.ask "What's your character's age? "
    race = ask_for_race("Type your character's race (Must be 'Dwarf', 'Elf', 'Human' or 'Orc') ", game)

    UI.print "Type your character's class [#{available_klasses.join(', ')}]", :yellow
    klass = ask_for_klass("> ", game)

    UI.print "Generating name...", :green if name.empty?

    character = game.create_new_character(name, age, race, klass)

    UI.print "Character '#{character.name}' created.", :green
  when '2'
    name = ''
    klass_exists = true

    while klass_exists || name.empty?
      name = UI.ask "What's the class name? "
      klass_exists = game.klass_exists?(name)

      UI.print "The class name must be provided.", :red if name.empty?
      UI.print "Class '#{name}' already exists.", :red if klass_exists
    end

    UI.print "Type the abilities for '#{name}' class? (Separeted by comma, ex: A, B, ...)", :yellow
    abilities = UI.ask "> "
    abilities = abilities.split(',').map(&:strip)

    life = UI.ask "What's the life for '#{name}' class? "
    attack = UI.ask "What's the attack for '#{name}' class? "
    defense = UI.ask "What's the defense for '#{name}' class? "
    inteligence = UI.ask "What's the inteligence for '#{name}' class? "
    force = UI.ask "What's the force for '#{name}' class? "

    modifiers = {
      life: life.to_i,
      attack: attack.to_i,
      defense: defense.to_i,
      inteligence: inteligence.to_i,
      force: force.to_i
    }

    klass = game.create_new_klass(name, abilities, modifiers)
  when '3'
    UI.print "What's the character name? [#{available_characters.join(', ')}]", :yellow
    character = ask_for_character("> ", game)
    UI.print "What's the class name? [#{available_klasses.join(', ')}]", :yellow
    klass = ask_for_klass("> ", game)

    success = game.add_klass_to_character(character, klass)

    UI.print "#{klass.name} class added to #{character.name}'s character", :green if success
    UI.print "Could not add #{klass.name} class to #{character.name}'s character'. Try again!", :red unless success
  when '4'
    UI.table(game.list_klasses)
  when '5'
    race = ask_for_race("Type the race (Must be 'Dwarf', 'Elf', 'Human' or 'Orc') ", game)
    UI.table(game.list_characters_by_race(race))
  when '6'
    UI.print "Type your character's class [#{available_klasses.join(', ')}]", :yellow
    klass = ask_for_klass("> ", game)

    UI.table(game.list_characters_by_klass(klass))
  when GAME_OVER_OPTION
    goodbye
  else
    UI.print "[Invalid Option]", :red
  end

  UI.ask "\n[Press Enter to continue]", :cyan
  UI.clear
end
