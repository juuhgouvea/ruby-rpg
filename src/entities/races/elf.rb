require_relative 'race'

class Elf < Race
  def self.race_name
    'Elf'
  end

  def self.attributes
    {
      life: 25,
      attack: 5,
      defense: 6,
      inteligence: 20,
      force: 10
    }
  end
end
