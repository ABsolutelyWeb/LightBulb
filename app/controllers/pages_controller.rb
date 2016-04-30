class PagesController < ApplicationController
  def homepage
    @free_plan = Plan.find(1)
    @premium_plan = Plan.find(2)
  end
  
  def about
    
  end
end
