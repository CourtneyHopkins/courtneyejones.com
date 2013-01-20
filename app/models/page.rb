class Page < ActiveRecord::Base
  attr_accessible :body, :slug, :title, :redirect
end
