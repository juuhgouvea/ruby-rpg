require_relative 'race'

class Orc < Race
  def initialize(name = 'Orc', attributes = default_attributes)
    super(name, attributes)
  end

  protected
  def default_attributes
    {
      life: 15,
      attack: 12,
      defense: 5,
      inteligence: 2,
      force: 25
    }
  end
end
