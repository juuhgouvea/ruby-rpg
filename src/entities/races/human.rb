require_relative 'race'

class Human < Race
  def self.race_name
    'Human'
  end

  def self.attributes
    {
      life: 20,
      attack: 8,
      defense: 8,
      inteligence: 10,
      force: 10
    }
  end
end
