class PortfolioController < ApplicationController
  def index
    @categories = Category.all
  end
  
end
