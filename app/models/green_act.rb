class GreenAct < ApplicationRecord
  belongs_to :user

  validates_presence_of :content, message: "is required"
  validates_length_of :content, maximum: 280
  validates_length_of :details, maximum: 10_000
end
