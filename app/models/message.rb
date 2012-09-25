class Message < ActiveRecord::Base
  belongs_to :user
  attr_accessible :content, :name, :title
end
