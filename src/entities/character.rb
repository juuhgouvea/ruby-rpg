class Character
  attr_accessor :klasses
  attr_reader :name, :age, :race

  def initialize(name, age, race, klasses = [])
    @name = name
    @age = age
    @race = race
    @klasses = klasses
  end
end
