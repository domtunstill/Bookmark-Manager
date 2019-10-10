require './lib/database_connection'

if ENV['ENVIRONMENT'] == 'test'
  DatabaseConnection.setup(dbname: 'bookmark_manager_test')
else
  DatabaseConnection.setup(dbname: 'bookmark_manager')
end
