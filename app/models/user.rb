class User < ApplicationRecord
	has_many :reservations, dependent: :destroy
	has_many :sells, dependent: :destroy
	validates :username, presence:true, uniqueness: true
	validates :password, presence:true
end
