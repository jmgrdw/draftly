class Product < ActiveRecord::Base
  attr_accessible :amount, :title
  
  has_many :transactions
  has_many :accounts, :through => :transactions
  
  scope :ascending, order('amount ASC')
    
  def self.create_five_products
    products = [ ["Fifty Dollars", 50], ["Ten Dollars", 10], ["Twenty Dollars", 20], ["Hundred Dollars", 100], ["Five Dollars", 5]]
    products.each do |p|
      product = Product.new(:title => p[0], :amount => p[1])
      product.save
    end
  end
end