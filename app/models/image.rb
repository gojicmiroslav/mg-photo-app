class Image < ActiveRecord::Base
  belongs_to :user
  mount_uploader :picture, PictureUploader
  validate :picture_size

  private

  def picture_size
  	if picture_size > 1.megabytes
  		errors.add(:picture, "should be less than 5MB")
  	end
  end
end
