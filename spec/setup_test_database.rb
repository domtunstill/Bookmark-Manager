require 'pg'

def setup_test_database

  p "Setting up test database..."

  db = PG.connect(dbname: 'bookmark_manager_test')

  # Clear the bookmarks table
  db.exec("TRUNCATE bookmarks;")

end
