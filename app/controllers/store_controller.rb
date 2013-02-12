class StoreController < ApplicationController
  def index
    @products = Product.order(:title) # ABC
  end
end
