class Klass
  @attr_reader = :name, :abilities, :modifiers

  def initialize(name, abilities, modifiers)
    @name = name
    @abilities = abilities
    @modifiers = modifiers
  end
end
