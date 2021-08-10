class VendingMachine
    # 0-①,
    MONEY = [10, 50, 100, 500, 1000].freeze
    attr_reader :total, :sale_amount, :stocks, #:unsdn
  ​
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
  ​
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
  ​
    def stock_count(name, idx)
      @new_stocks[idx].drinks.select { |drink| drink.name == name }.count
    end
  end
  ​
  ​
  ​
  class Category
    attr_accessor :drinks
  ​
    def initialize(drinks)
      @drinks = drinks
      # 初期化のタイミングでvalidate_uniqueとvalidate_classをした方がいいかも
    end
  ​
    # ドリンク名 x 値段が同じ組み合わせのドリンクしか入っていなければtrue 一つでも違うのがあるとfalse
    def validate_unique
      @drinks.each do |drink1|
        @drinks.each do |drink2|
          false unless drink1.name === drink2.name || drink1.price === drink2.price
          break
        end
      end
      true
    end
  ​
    # ドリンククラス以外が入っていなければtrue 一つでも違うのがあるとfalse
    def validate_class
      @drinks.each { |drink| false unless drink.kind_of?(Drink) }
      true
    end
    #--------------------------------------------------------------------------------------------------------------
  ​
    # TODO 3-①②③⑤の参考コード（要解読、参考そのまま。いじってない。”在庫の管理は配列のindexではなく、ハッシュのkeyでした方がいいかも”ってところ気になる）-----------
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
  ​
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
    def unstock_drink(name)
      @unsdn << name unless @unsdn.include?(name)
    end
  ​
    # ドリンク選択
    # TODO: ソニックガーデンさんコードレビュー
    # 在庫の管理は配列のindexではなく、ハッシュのkeyでした方がいいかも
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