class Character
  attr_accessor :klasses
  attr_reader :name, :age, :race

  def initialize(name, age, race, klasses = [])
    @name = name
    @age = age
    @race = race
    @klasses = klasses
  end

  def calculate_attributes
    attributes = @klasses.map do |klass| klass.modifiers end
    attributes << @race.attributes

    total = attributes.reduce({}) do |total, value|
      value.each do |key, attribute_value|
        total[key] = 0 unless total.include?(key)
        total[key] += attribute_value
      end
      total
    end
    
    total
  end
end
