class Contact < ApplicationRecord
  validates :telefono, numericality: { greater_than: 0 }, presence: true
  belongs_to :client
end
