require 'test_helper'

class ProductTest < ActiveSupport::TestCase

  fixtures :products

  test "product is not valid without a unique title - i18n" do
    product = Product.new(title: products(:ruby).title,
                          description: "krororo",
                          price: 1,
                          image_url: "f.jpg")
    assert !product.save
    assert_equal I18n.translate('activerecord.errors.messages.taken'),
                 product.errors[:title].join('; ')
  end

  test "prosuct attributes must not be empty" do
    product = Product.new
    assert product.invalid?
    assert product.errors[:title].any?
    assert product.errors[:description].any?
    assert product.errors[:price].any?
    assert product.errors[:image_url].any?
  end

  test "product price must be positive" do
    product = Product.new(title: "tratata",
                          description: "ololo",
                          image_url: "z.jpg")
    product.price = -1
    assert product.invalid?
    assert_equal "must be greater than or equal to 0.01", product.errors[:price].join('; ')

    product.price = 0
    assert product.invalid?
    assert_equal "must be greater than or equal to 0.01", product.errors[:price].join('; ')

    product.price = 1
    assert product.valid?
  end

  def new_product(image_url)
    Product.new(title: "tratata",
                description: "ololo",
                price: 1,
                image_url: image_url)
  end

  test "image URL" do

    ok  = %w{ f.gif f.jpg f.png F.GIF F.Jpg http://a.b.c/x/y/z/f.png }
    bad = %w{ f.doc f.gif/more f.gif.more }

    ok.each do |name|
      assert new_product(name).valid?, "#{name} shouldn't be invalid"
    end

    bad.each do |name|
      assert new_product(name).invalid?, "#{name} shouldn't be valid"
    end

  end

end
