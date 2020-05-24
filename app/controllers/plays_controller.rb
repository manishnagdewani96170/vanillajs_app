class PlaysController < ApplicationController
  # POST /plays
  # POST /plays.json
  def create
    @play = Play.new(play_params)
    if @play.save
      render json: @play, status: :created
    else
      render json: @play.errors, status: :unprocessable_entity 
    end
  end
  
  private
    # Only allow a list of trusted parameters through.
    def play_params
      params.require(:play).permit(:timer_value, :image_url)
    end
end
