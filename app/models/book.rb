class Book < ApplicationRecord
  belongs_to :category
  has_many :borrowings, dependent: :destroy
  has_many :students, through: :borrowings
  
  validates :title, presence: true
  validates :author, presence: true
  validates :isbn, presence: true, uniqueness: true
  
  scope :available, -> { where(available: true) }
  scope :out_of_stock, -> { where(available: false) }
  
  def currently_borrowed_by?(student)
    borrowings.where(student: student, returned_at: nil).exists?
  end
  
  def current_borrower
    borrowings.where(returned_at: nil).first&.student
  end
end
