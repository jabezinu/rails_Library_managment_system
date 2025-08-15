class Student < ApplicationRecord
  has_many :borrowings, dependent: :destroy
  has_many :books, through: :borrowings
  
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :student_id, presence: true, uniqueness: true
  
  def active_borrowings
    borrowings.where(returned_at: nil)
  end
  
  def borrowing_history
    borrowings.where.not(returned_at: nil)
  end
end
