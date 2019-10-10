require 'database_connection'

describe DatabaseConnection do

  describe '.setup' do
    it 'it connects to the database and saves the connection as an instance variable' do
      DatabaseConnection.setup(dbname: 'bookmark_manager_test')
      expect(DatabaseConnection.instance).not_to be nil
    end
  end

  describe '.instance' do
    it 'the instance method saves the connection' do
      connection = DatabaseConnection.setup(dbname: 'bookmark_manager_test')
      expect(DatabaseConnection.instance). to eq connection
    end
  end

  describe '.query' do
    it 'takes an SQL string and executes it' do
      DatabaseConnection.setup(dbname: 'bookmark_manager_test')
      query = DatabaseConnection.query("INSERT INTO bookmarks (url, title) VALUES('http://www.makers.tech', 'Makers') RETURNING id;")
      select = DatabaseConnection.query("SELECT * FROM bookmarks")
      expect(select.first['id']).to eq query.first['id']
    end
  end

end
