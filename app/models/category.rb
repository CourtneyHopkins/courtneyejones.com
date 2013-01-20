class Category < ActiveRecord::Base
  attr_accessible :category_name
  has_many :category_items
  has_many :items, through: :category_items
end
