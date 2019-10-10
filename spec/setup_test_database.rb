require 'pg'

def setup_test_database

  p "Setting up test database..."
  db = PG.connect(dbname: 'bookmark_manager_test')
  # Clear the bookmarks table
  db.exec("DROP TABLE comments;")
  db.exec("DROP TABLE bookmarks;")
  db.exec("CREATE TABLE bookmarks(id SERIAL PRIMARY KEY, url VARCHAR(60), title VARCHAR(60));")
  db.exec("CREATE TABLE comments(id SERIAL PRIMARY KEY, bookmark_id INTEGER REFERENCES bookmarks (id), comment VARCHAR(240));")
  
end
