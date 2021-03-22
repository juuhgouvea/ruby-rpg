require 'faker'
require_relative 'containers/race_container'
require_relative 'containers/klass_container'
require_relative 'containers/character_container'

class Game
  def initialize(klasses = [], characters = [])
    @race_container = RaceContainer.new
    @klass_container = KlassContainer.new(klasses)
    @character_container = CharacterContainer.new(characters)
  end

  def races
    @race_container.races
  end

  def klasses
    @klass_container.klasses
  end

  def characters
    @character_container.characters
  end

  def create_new_character(name, age, race, klass = [])
    name = generate_character_name if name.nil? || name.empty?
    new_character = Character.new(name, age, race, [klass])
    @character_container << new_character

    new_character
  end

  def create_new_klass(name, abilities = [], modifiers = {})
    klass = Klass.new(name, abilities, modifiers)
    @klass_container << klass

    klass
  end

  def add_klass_to_character(character, klass)
    false if character.nil? || klass.nil?
    character.klasses << klass
  end

  def list_klasses
    data = []
    @klass_container.klasses.map do |klass|
      data << {
        "name" => klass.name,
        "life" => klass.modifiers[:life],
        "attack" => klass.modifiers[:attack],
        "defense" => klass.modifiers[:defense],
        "inteligence" => klass.modifiers[:inteligence],
        "force" => klass.modifiers[:force],
      }
    end
    
    data
  end

  def find_race(values)
    @race_container.find_by_name(values)
  end

  def find_klass(values)
    @klass_container.find_by_name(values)
  end

  def find_character(values)
    @character_container.find_by_name(values)
  end

  def race_exists?(name)
    find_race([name]).any?
  end

  def klass_exists?(name)
    find_klass([name]).any?
  end

  def character_exists?(name)
    find_character([name]).any?
  end

  private

  def generate_character_name
    begin
      name = Faker::Games::Witcher.character
    end while character_exists?(name)

    name
  end
end
