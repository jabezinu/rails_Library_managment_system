class Borrowing < ApplicationRecord
  belongs_to :student
  belongs_to :book
  
  validates :borrowed_at, presence: true
  validate :book_must_be_available, on: :create
  validate :student_cannot_borrow_same_book_twice, on: :create
  
  before_create :set_borrowed_at, :mark_book_unavailable
  after_update :mark_book_available, if: :saved_change_to_returned_at?
  
  scope :active, -> { where(returned_at: nil) }
  scope :returned, -> { where.not(returned_at: nil) }
  
  def return_book!
    update!(returned_at: Time.current)
  end
  
  def active?
    returned_at.nil?
  end
  
  private
  
  def set_borrowed_at
    self.borrowed_at ||= Time.current
  end
  
  def mark_book_unavailable
    book.update!(available: false)
  end
  
  def mark_book_available
    book.update!(available: true) if returned_at.present?
  end
  
  def book_must_be_available
    errors.add(:book, "is not available for borrowing") unless book&.available?
  end
  
  def student_cannot_borrow_same_book_twice
    if student&.borrowings&.active&.where(book: book)&.exists?
      errors.add(:book, "is already borrowed by this student")
    end
  end
end
