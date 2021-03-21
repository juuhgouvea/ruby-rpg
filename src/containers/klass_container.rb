require_relative '../entities/klass'

class KlassContainer
  attr_reader :klasses

  def initialize(klasses = default_klasses)
    @klasses = klasses
  end

  def find_by_name(values = [])
    lower_values = values.map { |value| value.downcase.strip }
    @klasses.select { |klass| lower_values.include?(klass.name.downcase) }
  end

  def <<(klass)
    @klasses << klass
  end

  private

  def default_klasses
    []
  end
end
