require 'nokogiri'
require 'open-uri'
require 'pg'

# Database connection
db_config = YAML.load_file('../config/database.yml')['development']
conn = PG.connect(db_config)

# Web scraping logic
url = 'https://example.com/books' # Replace with your target URL
doc = Nokogiri::HTML(URI.open(url))

books = doc.css('.book') # Replace with your specific selector

books.each do |book|
  title = book.css('.title').text
  description = book.css('.description').text

  # Insert data into the database
  conn.exec_params('INSERT INTO books (title, description) VALUES ($1, $2)', [title, description])
end

conn.close
