class User < ApplicationRecord
	has_many :reservations, dependent: :destroy
	has_many :sells, dependent: :destroy
	validates :username, presence:true, uniqueness: { case_sensitive: false }
	validates :password, presence:true
end
