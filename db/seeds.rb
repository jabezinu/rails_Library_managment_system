# Create Categories
categories = [
  { name: "Fiction", description: "Novels, short stories, and other fictional works" },
  { name: "Non-Fiction", description: "Biographies, history, science, and factual books" },
  { name: "Science", description: "Scientific research, textbooks, and educational materials" },
  { name: "Technology", description: "Programming, computer science, and technology books" },
  { name: "Literature", description: "Classic literature and poetry" },
  { name: "Business", description: "Business, economics, and management books" }
]

categories.each do |category_attrs|
  Category.find_or_create_by(name: category_attrs[:name]) do |category|
    category.description = category_attrs[:description]
  end
end

puts "Created #{Category.count} categories"

# Create Books
books_data = [
  { title: "To Kill a Mockingbird", author: "Harper Lee", isbn: "978-0-06-112008-4", category: "Literature" },
  { title: "1984", author: "George Orwell", isbn: "978-0-452-28423-4", category: "Fiction" },
  { title: "The Great Gatsby", author: "F. Scott Fitzgerald", isbn: "978-0-7432-7356-5", category: "Literature" },
  { title: "Clean Code", author: "Robert C. Martin", isbn: "978-0-13-235088-4", category: "Technology" },
  { title: "The Lean Startup", author: "Eric Ries", isbn: "978-0-307-88789-4", category: "Business" },
  { title: "Sapiens", author: "Yuval Noah Harari", isbn: "978-0-06-231609-7", category: "Non-Fiction" },
  { title: "The Pragmatic Programmer", author: "David Thomas", isbn: "978-0-201-61622-4", category: "Technology" },
  { title: "Atomic Habits", author: "James Clear", isbn: "978-0-7352-1129-2", category: "Non-Fiction" },
  { title: "The Catcher in the Rye", author: "J.D. Salinger", isbn: "978-0-316-76948-0", category: "Literature" },
  { title: "Introduction to Algorithms", author: "Thomas H. Cormen", isbn: "978-0-262-03384-8", category: "Technology" },
  { title: "A Brief History of Time", author: "Stephen Hawking", isbn: "978-0-553-38016-3", category: "Science" },
  { title: "The Art of War", author: "Sun Tzu", isbn: "978-1-59030-963-7", category: "Non-Fiction" }
]

books_data.each do |book_attrs|
  category = Category.find_by(name: book_attrs[:category])
  Book.find_or_create_by(isbn: book_attrs[:isbn]) do |book|
    book.title = book_attrs[:title]
    book.author = book_attrs[:author]
    book.category = category
    book.available = true
  end
end

puts "Created #{Book.count} books"

# Create Students
students_data = [
  { name: "Alice Johnson", email: "alice.johnson@university.edu", student_id: "STU001" },
  { name: "Bob Smith", email: "bob.smith@university.edu", student_id: "STU002" },
  { name: "Carol Davis", email: "carol.davis@university.edu", student_id: "STU003" },
  { name: "David Wilson", email: "david.wilson@university.edu", student_id: "STU004" },
  { name: "Emma Brown", email: "emma.brown@university.edu", student_id: "STU005" },
  { name: "Frank Miller", email: "frank.miller@university.edu", student_id: "STU006" },
  { name: "Grace Lee", email: "grace.lee@university.edu", student_id: "STU007" },
  { name: "Henry Taylor", email: "henry.taylor@university.edu", student_id: "STU008" }
]

students_data.each do |student_attrs|
  Student.find_or_create_by(student_id: student_attrs[:student_id]) do |student|
    student.name = student_attrs[:name]
    student.email = student_attrs[:email]
  end
end

puts "Created #{Student.count} students"

# Create some sample borrowings
if Borrowing.count == 0
  # Create some active borrowings
  alice = Student.find_by(student_id: "STU001")
  bob = Student.find_by(student_id: "STU002")
  carol = Student.find_by(student_id: "STU003")
  
  clean_code = Book.find_by(title: "Clean Code")
  sapiens = Book.find_by(title: "Sapiens")
  
  if alice && clean_code
    Borrowing.create!(
      student: alice,
      book: clean_code,
      borrowed_at: 5.days.ago
    )
  end
  
  if bob && sapiens
    Borrowing.create!(
      student: bob,
      book: sapiens,
      borrowed_at: 3.days.ago
    )
  end
  
  # Create some returned borrowings
  if carol
    gatsby = Book.find_by(title: "The Great Gatsby")
    if gatsby
      borrowing = Borrowing.create!(
        student: carol,
        book: gatsby,
        borrowed_at: 10.days.ago
      )
      borrowing.update!(returned_at: 2.days.ago)
    end
  end
  
  puts "Created sample borrowings"
end

puts "Seed data created successfully!"
puts "Categories: #{Category.count}"
puts "Books: #{Book.count}"
puts "Students: #{Student.count}"
puts "Borrowings: #{Borrowing.count}"