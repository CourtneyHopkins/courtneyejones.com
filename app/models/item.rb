class Item < ActiveRecord::Base
  attr_accessible :item_name, :position, :assignments
  attr_accessor :assignments
  has_many :category_items
  has_many :categories, through: :category_items
end
