class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates_presence_of :name, :username
  validates_length_of :name, :username, in: 2..25
  validates_uniqueness_of :username, case_sensitive: false
  validates_format_of :username,
    with:    /\A[a-zA-Z0-9_\-]+\z/,
    message: "only allows letters, numbers, _ and -"
end
