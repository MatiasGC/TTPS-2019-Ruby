class Contact < ApplicationRecord
  validates :telefono, presence: true
  belongs_to :client
end
