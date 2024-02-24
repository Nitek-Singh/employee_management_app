class Employee < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze

  has_many :phone_numbers, dependent: :destroy
  accepts_nested_attributes_for :phone_numbers

  validates :first_name, :last_name, :date_of_joining, :salary, presence: true
  validates :email, uniqueness: { case_sensitive: false }, format: { with: VALID_EMAIL_REGEX }, presence: true, length: { maximum: 100 }
  validate :at_least_one_phone_number

  private

  def at_least_one_phone_number
    if phone_numbers.empty? || phone_numbers.all? { |phone_number| phone_number.marked_for_destruction? }
      errors.add(:phone_numbers, "must be present")
    end
  end
end
