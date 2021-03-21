require_relative 'race'

class Dwarf < Race
  def initialize(name = 'Dwarf', attributes = default_attributes)
    super(name, attributes)
  end

  protected
  def default_attributes
    {
      life: 18,
      attack: 9,
      defense: 11,
      inteligence: 7,
      force: 20
    }
  end
end
