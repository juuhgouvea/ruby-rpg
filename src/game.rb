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
    new_character = Character.new(name, age, race, klass)
    @character_container << new_character

    new_character
  end

  def find_race(name)
    @race_container.find_by_name(name)
  end

  def find_klass(name)
    @klass_container.find_by_name(name)
  end

  private

  def generate_character_name
    Faker::Games::Witcher.character
  end
end
