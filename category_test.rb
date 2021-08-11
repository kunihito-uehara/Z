require "./drink"
class Category
  attr_accessor :drinks
​​# 成木さん
  def initialize(drinks)
    @drinks = drinks
    # 初期化のタイミングでvalidate_uniqueとvalidate_classをした方がいいかも
  end
​
  # ドリンク名 x 値段が同じ組み合わせのドリンクしか入っていなければtrue 一つでも違うのがあるとfalse
  #増子
  def validate_unique
    @drinks.each do |drink1|
      @drinks.each do |drink2|
        false unless drink1.name === drink2.name || drink1.price === drink2.price
        break
      end
    end
    true
  end

  def puts_test
    @drinks.each do |drink1|
      @drinks.each do |drink2|
      p "----1---"
      p drink1.name
      p drink1.price
      p "----2---"
      p drink2.name
      p drink2.price
      p "--------"
      end
    end
  end

​#増子
  # ドリンククラス以外が入っていなければtrue 一つでも違うのがあるとfalse
  def validate_class
    @drinks.each { |drink| false unless drink.kind_of?(Drink) }
    true
  end

end
