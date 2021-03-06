require "./drink"
require "./category"
class VendingMachine
  MONEY = [10, 50, 100, 500, 1000].freeze
  attr_reader :total, :sale_amount, :stocks, :unsdn
  def initialize
    @total = 0
    @sale_amount = 0
    @stocks = []
    @drinks = []
    5.times {@drinks.push(Drink.cola)}
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
  def stock_info
    @new_stocks = []
    @stocks.each do |stock|
    @new_stocks << stock unless stock.drinks.empty?
    end
    unless @new_stocks.empty?
      @new_stocks.each_with_index do |stock, idx|
        drink = stock.drinks.first
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
        drink = stock.drinks.first
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
    puts "現在の売り上げは#{sale_amount}円です！"
  end
end

vm = VendingMachine.new
