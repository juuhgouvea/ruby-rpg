require_relative 'race'

class Human < Race
  def initialize(name = 'Human', attributes = default_attributes)
    super(name, attributes)
  end

  protected
  def default_attributes
    {
      life: 20,
      attack: 8,
      defense: 8,
      inteligence: 10,
      force: 10
    }
  end
end
