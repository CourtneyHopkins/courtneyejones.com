class Page < ActiveRecord::Base
  attr_accessible :body, :slug, :title
end
