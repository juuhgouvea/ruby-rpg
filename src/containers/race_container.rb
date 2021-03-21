require_relative '../entities/races/dwarf'
require_relative '../entities/races/elf'
require_relative '../entities/races/human'
require_relative '../entities/races/orc'

class RaceContainer
  attr_reader :races

  def initialize(races = default_races)
    @races = races
  end

  def find_by_name(values = [])
    lower_values = values.map { |value| value.downcase.strip }
    @races.select { |race| lower_values.include?(race.name.downcase) }
  end

  private

  def default_races
    [
      Dwarf.new,
      Human.new,
      Elf.new,
      Orc.new
    ]
  end
end
