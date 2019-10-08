require 'bookmarks'

describe Bookmarks do

  before(:each) do
    connection = PG.connect(dbname: 'bookmark_manager_test')
    # Add the test data
    connection.exec("INSERT INTO bookmarks (url) VALUES('http://www.google.com');")
  end

  it 'returns a list of bookmarks' do
    expect(Bookmarks.all).to include "http://www.google.com"
  end

  describe "#create" do
    it "saves a new entry to the bookmarks table" do
      Bookmarks.create("https://www.makers.tech")
      expect(Bookmarks.all).to include "https://www.makers.tech"
    end
  end

end
