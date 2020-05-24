class Attachment < ApplicationRecord
  mount_uploader :image, FileUploader
  validates_presence_of :image
end
