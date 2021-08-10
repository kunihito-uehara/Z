require "./drink"
require "./category"
class VendingMachine
  # 0-①,
  MONEY = [10, 50, 100, 500, 1000].freeze
  attr_reader :total, :sale_amount, :stocks, :unsdn
​# 成木さん
  def initialize
    @total = 0
    @sale_amount = 0
    @stocks = []
    @drinks = []
​
    # 2-①(Drinkクラス作る)
    5.times {@drinks.push(Drink.cola)}
​
    # TODO 2-② このCategoryクラスは必要なのか？----------------
    # c = Category.new(@drinks)
    # @stocks.push(c) if c.validate_class && c.validate_unique
    # @unsdn = []
    # -------------------------------------------------------
  end
​
  # 0-③
  def total
    puts "現在の投入金額合計は#{@total}円ですよ！"
  end
​
  # 0-①②, 1-①
  def insert(money)
    if MONEY.include?(money)
      @total += money
    else
      puts "#{money}円は使えませんよ！"
    end
  end
​
  # 0-④
  def pay_back
    puts "#{@total}円返却"
    @total = 0
  end
​
​
​
​
  # TODO 2-②の参考コード（要解読、参考そのまま。いじってない）----------------------------------------------------------------
​#青木さん
  def stock_info
    @new_stocks = []
    @stocks.each do |stock|
      # 在庫を保有している配列を@new_stocksに格納
    @new_stocks << stock unless stock.drinks.empty?
  end
​
    unless @new_stocks.empty?
      @new_stocks.each_with_index do |stock, idx|
        drink = stock.drinks.first
        puts "名前:#{drink.name} \n 値段:#{drink.price} \n 在庫:#{stock_count(drink.name, idx)}"
      end
    else
      puts "在庫切れです。"
    end
  end
​​#青木さん
  def stock_count(name, idx)
    @new_stocks[idx].drinks.select { |drink| drink.name == name }.count
  end
​
​
​

  #--------------------------------------------------------------------------------------------------------------
​
  # TODO 3-①②③⑤の参考コード（要解読、参考そのまま。いじってない。”在庫の管理は配列のindexではなく、ハッシュのkeyでした方がいいかも”ってところ気になる）-----------
  ​#尾原さん
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
​#尾原さん
  def drink_menu
    puts "投入金額 #{total}円"
    puts "-----------------------------------------"
    unless @stocks.empty?
      @stocks.each_with_index do |stock, idx|
        drink = stock.drinks.first#重複する記述を変数に代入
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
​
  # ドリンクメニュー画面に表示する品切れ中のドリンク名を保管するための配列
  #上原さん
  def unstock_drink(name)
    @unsdn << name unless @unsdn.include?(name)
  end
​
  # ドリンク選択
  # TODO: ソニックガーデンさんコードレビュー
  # 在庫の管理は配列のindexではなく、ハッシュのkeyでした方がいいかも
  #上原さん
  def purchase_select(int)#@intにすると引数ではなくインスタンス変数を参照しに行ってしまいエラーになる。
    drink = @stocks[int].drinks.first#重複する記述を変数に代入
    if @stocks[int].drinks.length > 0 && drink.price <= @total
      #3-⑤
      @total -= drink.price
      @sale_amount += drink.price
      puts "#{drink.name}を購入しました。"
      # 削除後、再代入しないと初回購入時は削除されるけど次回購入時以降は削除されなくなる。
      @stocks[int].drinks = @stocks[int].drinks.drop(1)
    else
      puts "#{drink.price - @total}円不足しています。お金を投入して下さい。"
    end
  end
  ​
  #-----------------------------------------------------------------------------------------------------------------------------------------------------
  #3-④ これでいいのかな？新規作成
  def sale_amount
      puts "現在の売り上げは#{sale_amount}円です！"
    end
  end
end
