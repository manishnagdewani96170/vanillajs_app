class HomeController < ApplicationController
  def index; end

  def game
    @plays = Play.all
  end  
end
