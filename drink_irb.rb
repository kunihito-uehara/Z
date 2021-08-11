class Drink
  attr_reader :name,:price
  def initialize(name, price)
    @name = name
    @price = price
  end
  def self.cola
    self.new("コーラ",120)
  end
end
