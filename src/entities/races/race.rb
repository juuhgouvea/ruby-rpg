class Race
  attr_reader :name, :attributes

  def initialize(name = 'Race', attributes = default_attributes)
    @name = name
    @attributes = attributes
  end

  protected
  def default_attributes
    {
      life: 0,
      attack: 0,
      defense: 0,
      inteligence: 0,
      force: 0
    }
  end
end
