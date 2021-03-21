require_relative 'race'

class Elf < Race
  def initialize(name = 'Elf', attributes = default_attributes)
    super(name, attributes)
  end

  protected
  def default_attributes
    {
      life: 25,
      attack: 5,
      defense: 6,
      inteligence: 20,
      force: 10
    }
  end
end
