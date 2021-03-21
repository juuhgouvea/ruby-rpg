require_relative '../entities/character'

class CharacterContainer
  attr_reader :characters

  def initialize(characters = default_characters)
    @characters = characters
  end

  def find_by_name(values = [])
    lower_values = values.map { |value| value.downcase.strip }
    @characters.select { |character| lower_values.include?(character.name.downcase) }
  end

  def <<(character)
    @characters << character
  end

  private

  def default_characters
    []
  end
end
