class Event < ActiveRecord::Base
  belongs_to :repeat_type
  belongs_to :user

  validates :title, presence: true
  validates :start, presence: true
end
