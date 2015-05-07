class Chef < ActiveRecord::Base
  has_many :recipes
  has_many :likes
  
  validates :chefname, presence: true, uniqueness: { case_sensitive: false }
  
  before_save { self.email = email.downcase }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 105 }, 
                    uniqueness: { case_sensitive: false }, 
                    format: { with: VALID_EMAIL_REGEX }

  has_secure_password
end 