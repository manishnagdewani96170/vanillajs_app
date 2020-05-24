class AttachmentsController < ApplicationController
  before_action :check_images_exist?, only: :create
  
  def index
    @attachments = Attachment.all.sample(10)
    @images = @attachments.collect{ |c| c.image.url }
    render json: @images, status: :ok 
  end
    
  def create
    images = []
    params[:images].each do |img|
      images << { image: img }  
    end
    @attachment = Attachment.create!(images)
    if @attachment
      redirect_to root_path, notice: "Uploaded successfully."
    else
      redirect_to root_path, error: 'Something wnet wrong.'
    end    
  end
  
  private
  def check_images_exist?
    redirect_to root_path, alert: "Please select images to upload" unless params[:images].present?
  end  
end
