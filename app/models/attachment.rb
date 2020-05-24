class Attachment < ApplicationRecord
  #constants
  RANDOM_COUNT = 10
  #Uploader
  mount_uploader :image, FileUploader
  #validations
  validates_presence_of :image
end
