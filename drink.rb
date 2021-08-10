class Drink
  attr_reader :name,:price
​
  def initialize(name, price)
    @name = name
    @price = price
  end
​
  # 2-①(クラスメソッド定義)
  def self.cola
    self.new("コーラ",120)
  end
end
