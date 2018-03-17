# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require "csv"



CSV.foreach('db/users.csv', headers: true) do |row|
  User.create(:name => row[1], :email => row[2], :password => row[3], :profile => row[4], :icon_path => row[7])
end

CSV.foreach('db/books.csv', headers: true) do |row|
  b = Book.create(:title => row[1], :isbn10 => row[3], :isbn13 => row[4], :google_books_id => row[5])
  [7,8,9,10,11].each{|n|
    break if row[n].blank?
    Author.create(:name => row[n], :book_id => b.id )
  }
end


# CSV.foreach('db/books.csv', headers: true) do |row|
#   Book.create(:title => row[1], :isbn10 => row[3], :isbn13 => row[4], :google_books_id => row[5])
# end
#
# CSV.foreach('db/authors.csv', headers: true) do |row|
#   Author.create(:name => row[1], :book_id => row[2] )
# end


CSV.foreach('db/contents.csv', headers: true) do |row|
  q = Question.create(:user_id =>row[1], :content=>row[2])
  [3,7,11].each{ |n|
    next if row[n].blank?
    if row[n+3].present?
      book = Book.find(row[n+3])
      Answer.create(:user_id => row[n], :title => book.title, :content => row[n+2], :question_id => q.id, :book_id => row[n+3])
    else
      Answer.create(:user_id => row[n], :title => row[n+1], :content => row[n+2], :question_id => q.id)
    end
  }

end
