class Tea < ApplicationRecord
  validates :name, :country, presence: true
end
