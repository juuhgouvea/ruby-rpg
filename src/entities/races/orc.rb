require_relative 'race'

class Orc < Race
  def self.race_name
    'Orc'
  end

  def self.attributes
    {
      life: 15,
      attack: 12,
      defense: 5,
      inteligence: 2,
      force: 25
    }
  end
end
