class User < ApplicationRecord
  has_many :attendances, dependent: :destroy
  has_secure_password
  
end
