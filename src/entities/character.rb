class Character
  def initialize(age, race, klasses = [], name = nil)
    @name = (name or generate_name)
    @age = age
    @race = race
    @klasses = klasses
  end

  def generate_name
    'random name'
  end
end
