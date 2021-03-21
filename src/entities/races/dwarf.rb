require_relative 'race'

class Dwarf < Race
  def self.race_name
    'Anão'
  end

  def self.attributes
    {
      life: 18,
      attack: 9,
      defense: 11,
      inteligence: 7,
      force: 20
    }
  end
end
