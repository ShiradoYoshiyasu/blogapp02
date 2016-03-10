class Article < ActiveRecord::Base
  belongs_to :category
  belongs_to :user
  mount_uploader :picture, PictureUploader
end
