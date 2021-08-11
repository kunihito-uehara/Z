class Category
  attr_accessor :drinks
  def initialize(drinks)
    @drinks = drinks
  end
  def validate_unique
    @drinks.each do |drink1|
      @drinks.each do |drink2|
        false unless drink1.name == drink2.name || drink1.price == drink2.price
        break
      end
    end
    true
  end
  def validate_unique_test
    @drinks.each do |drink1|
      @drinks.each do |drink2|
        false if !(drink1.name === drink2.name) && !(drink1.price === drink2.price)
        break
      end
    end
    true
  end
  def validate_unique_test_equal
    @drinks.each do |drink1|
      @drinks.each do |drink2|
        false unless drink1.name == drink2.name || drink1.price == drink2.price
        break
      end
    end
    true
  end
  def puts_test
    @drinks.each do |drink1|
      @drinks.each do |drink2|
      p "----1---"
      p drink1
      p "----2---"
      p drink2
      p "--------"
      end
    end
  end
  def puts_test_drink1
    @drinks.each do |drink1|
      @drinks.each do |drink2|
      p drink1
      end
    end
  end
  def puts_test_drink2
    @drinks.each do |drink1|
      @drinks.each do |drink2|
      p drink2
      end
    end
  end
  def validate_class
    @drinks.each { |drink| false unless drink.kind_of?(Drink) }
    true
  end
end


class Drink
  attr_reader :name,:price
  def initialize(name, price)
    @name = name
    @price = price
  end
  def self.cola
    self.new("コーラ",120)
  end
  def self.cola2
    self.new("コーラ",20)
  end
  def self.water
    self.new("水",500)
  end
end


class Snack
  attr_reader :name,:price
  def initialize(name, price)
    @name = name
    @price = price
  end
  def self.pocky
    self.new( "ポッキー",150)
  end
end


ドリンクをいれる箱用意
@drinks = []

ドリンクをいれます
120円のコーラ2本
2.times { @drinks.push(Drink.cola) }
20円のコーラ2本
2.times { @drinks.push(Drink.cola2) }

@drinks
  =>情報を持ったドリンクインスタンスの配列ということがわかる
  =>[ドリンク,ドリンク,ドリンク]
    (※全て異なるインスタンス)


ドリンク以外も入れてみます
150円のポッキー2こ
2.times { @drinks.push(Snack.pocky) }

入れたドリンク(インスタンス)をカテゴリー化(商品登録)します
c = Category.new(@drinks)

cは１つのカテゴリーインスタンス。
  =>こんな感じ。
    カテゴリー[[ドリンク,ドリンク,ドリンク,]]
    ＝＞いろはす[[水(100円),水(100円),水(100円)]]

ストックする箱を用意
@stocks = []

ストックします
@stocks.push(c) if c.validate_class && c.validate_unique



もし、カテゴリー化したドリンクインスタンス（cの中のドリンクたち）が、
下記の場合は自販機にストックできない。

  ①validate_class：ドリンククラスでないとき
    =>イメージ
      いちごみるく[
        [いちごみるく,100円(飲み物),
          いちごみるく,100円(飲み物),
          いちごみるく,100円(あめ🍬)]
        ]
    （❌100円入れていちごみるく押したら、違ういちごミルク出てきた）

 def validate_class
    @drinks.each { |drink| false unless drink.kind_of?(Drink) }
    true
  end

    ②＊validate_unique：名前と値段が一致してないとき
    =>イメージ
    いろはす[[水(100円),水(100円),水(500円)]]
    （❌いろはすの値段設定どうしたらいいの？）

    ”＜注意＞最初は、同じ種類かつ値段均一のドリンクをカテゴリー化(商品登録)して、自販機にストックしてくださいね！”

    def validate_unique
   @drinks.each do |drink1|
     @drinks.each do |drink2|
       false unless drink1.name === drink2.name || drink1.price === drink2.price
       break
     end
   end
   true
 end


？？？
入れたドリンク(インスタンス)をカテゴリー化(商品登録)します
c = Category.new(@drinks)
ソニックレビューの意味わかった
「そもそもストックできないなら、商品化もするな」
c = Category.new(@drinks)if c.validate_class && c.validate_unique

d
