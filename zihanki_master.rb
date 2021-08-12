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

class VendingMachine
  MONEY = [10, 50, 100, 500, 1000].freeze
  attr_reader :total, :sale_amount, :stocks, :unsdn
  def initialize
    @total = 0
    @sale_amount = 0
    @stocks = []
    @drinks = []
    5.times {@drinks.push(Drink.cola)}
    c = Category.new(@drinks)
    @stocks.push(c) if c.validate_class && c.validate_unique
    @unsdn = []
  end
  def total
    puts "現在の投入金額合計は#{@total}円ですよ！"
  end
  def insert(money)
    if MONEY.include?(money)
      @total += money
    else
      puts "#{money}円は使えませんよ！"
    end
  end
  def pay_back
    puts "#{@total}円返却"
    @total = 0
  end
  def store(drink, num)
    stocks_delete
    @unsdn.clear
    @drinks = []
    num.times { @drinks.push(drink) }
    c = Category.new(@drinks)
    @stocks.push(c) if c.validate_class && c.validate_unique
  end
  def stocks_delete
    @stocks.delete_if { |n| n.drinks.empty? }
  end
  def stock_info
    @new_stocks = []
    @stocks.each do |stock|
      @new_stocks << stock unless stock.drinks.empty?
      p "a:"
      p @new_stocks
    end
    unless @new_stocks.empty?
      @new_stocks.each_with_index do |stock, idx|
        drink = stock.drinks.first
        p "b:"
        p drink
        puts "名前:#{drink.name} \n 値段:#{drink.price} \n 在庫:#{stock_count(drink.name, idx)}"
      end
    else
      puts "在庫切れです。"
    end
  end
  def stock_count(name, idx)
    @new_stocks[idx].drinks.select { |drink| drink.name == name }.count
  end
  def purchase
    drink_menu
    input = gets
    if input == "x\n"
      pay_back
    elsif input.to_i >= 0 && input.to_i < @stocks.length
      @int = input.to_i
      purchase_select(@int) unless @stocks[@int].drinks.empty?
    end
  end
  def drink_menu
    puts "投入金額 #{total}円"
    puts "-----------------------------------------"
    unless @stocks.empty?
      @stocks.each_with_index do |stock, idx|
        p "c:"
        p stock
        drink = stock.drinks.first
        p "d:"
        p drink
        unstock_drink(drink.name) unless stock.drinks.empty?
        puts "[#{idx}]:#{drink.name} #{drink.price}円" unless stock.drinks.empty?
        puts "[#{idx}]:#{@unsdn[idx]}は、ただいま品切れ中です。" if stock.drinks.empty?
      end
    end
    puts "-----------------------------------------"
    puts "[x]払い戻し"
    puts ""
    puts "商品番号を選択してください。"
  end
  def unstock_drink(name)
    @unsdn << name unless @unsdn.include?(name)
  end
  def purchase_select(int)
    drink = @stocks[int].drinks.first
    if @stocks[int].drinks.length > 0 && drink.price <= @total
      @total -= drink.price
      @sale_amount += drink.price
      puts "#{drink.name}を購入しました。"
      @stocks[int].drinks = @stocks[int].drinks.drop(1)
    else
      puts "#{drink.price - @total}円不足しています。お金を投入して下さい。"
    end
  end
  def sale_amount
    puts "現在の売り上げは#{@sale_amount}円です！"
  end
end

vm = VendingMachine.new
vm.insert(1000)
vm.stock_info
