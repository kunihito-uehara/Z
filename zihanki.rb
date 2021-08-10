チームZ メンバー%i[なるきmr　あおきmr　おはらmr ますこms うえはら]
# 初期設定（自動販売機インスタンスを作成して、vmという変数に代入する）
# vm = VendingMachine.new
​
# 作成した自動販売機に100円を入れる
# vm.slot_money (100)
​
# 作成した自動販売機に入れたお金がいくらかを確認する（表示する）
# vm.current_slot_money
​
# 作成した自動販売機に入れたお金を返してもらう
# vm.return_money
​
class Drink
  attr_reader :name, :price
​
  def initialize(name, price)
      @name = name
      @price = price
    end
​
    def self.cola
      self.new("コーラ", 120)
    end
​
    def self.redbull
      self.new("レッドブル", 200)
    end
​
    def self.water
      self.new("水", 100)
    end
  end
​
class VendingMachine
    # ステップ０　お金の投入と払い戻しの例コード
    # ステップ１　扱えないお金の例コード
​
    # 10円玉、50円玉、100円玉、500円玉、1000円札を１つずつ投入できる。
    MONEY = [10, 50, 100, 500, 1000].freeze
​
    # （自動販売機に投入された金額をインスタンス変数の @slot_money に代入する）
    def initialize
    @total = 0
    @sale_amount = 0
    @stocks = []
    @drinks = []
    # コーラ5本いれる
    5.times { @drinks.push(Drink.cola) }
    c = Category.new(@drinks)
    @stocks.push(c) if c.validate_class && c.validate_unique
    @unsdn = []
    end
​
    # 投入金額の総計を取得できる。
    def current_slot_money
      # 自動販売機に入っているお金を表示する
      @slot_money
    end
​
    # 10円玉、50円玉、100円玉、500円玉、1000円札を１つずつ投入できる。
    # 投入は複数回できる。
    def slot_money(money)
      # 想定外のもの（１円玉や５円玉。千円札以外のお札、そもそもお金じゃないもの（数字以外のもの）など）
      # が投入された場合は、投入金額に加算せず、それをそのまま釣り銭としてユーザに出力する。
      return false unless MONEY.include?(money)
      # 自動販売機にお金を入れる
​
    end
​
    # 払い戻し操作を行うと、投入金額の総計を釣り銭として出力する。
    def return_money
      # 返すお金の金額を表示する
      puts @slot_money
      # 自動販売機に入っているお金を0円に戻す
      @slot_money = 0
    end
  end
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
end