class Comment < ActiveRecord::Base
  belongs_to :creator, :class_name => "User"
  belongs_to :event

  validates_presence_of :creator, :event
end
