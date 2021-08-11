require "./drink"
class Category
  attr_accessor :drinks
  def initialize(drinks)
    @drinks = drinks
  end
  def validate_unique
    @drinks.each do |drink1|
      @drinks.each do |drink2|
        false unless drink1.name === drink2.name || drink1.price === drink2.price
        break
      end
    end
    true
  end
  def validate_class
    @drinks.each { |drink| false unless drink.kind_of?(Drink) }
    true
  end
end
