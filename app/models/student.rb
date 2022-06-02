class Student < ApplicationRecord
  belongs_to :instructor#, dependent: :destroy

  validates :name, presence: true
  validates :age, numericality: { greater_than_or_equal_to: 18}
end
