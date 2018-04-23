class Event < ApplicationRecord

  belongs_to :user

  validates :user, presence: true
  validates :title, presence: true, length: { maximum: 255}
  validates :address, :datetime, presence: true
end
