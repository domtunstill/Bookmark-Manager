require 'bookmark'
require_relative 'database_helpers'

describe Bookmark do

  # before(:each) do
  #   db = PG.connect(dbname: 'bookmark_manager_test')
  #   # Add the test data
  # end

  describe ".all" do
    it 'returns a list of bookmarks' do
      bookmark = Bookmark.create(url: 'www.makers.tech', title: 'Makers')
      bookmarks = Bookmark.all
      expect(bookmarks.length).to eq 1
      expect(bookmarks.first).to be_a Bookmark
      expect(bookmarks.first.id).to eq bookmark.id
      expect(bookmarks.first.title).to eq 'Makers'
      expect(bookmarks.first.url).to eq 'http://www.makers.tech'
    end
  end

  describe ".create" do
    it "saves a new entry to the bookmarks table" do
      bookmark = Bookmark.create(url: "www.makers.tech", title: "Makers")
      persisted_data = persisted_data(id: bookmark.id)
      expect(bookmark.class).to eq Bookmark
      expect(bookmark.id).to eq persisted_data['id']
      expect(bookmark.title).to eq 'Makers'
      expect(bookmark.url).to eq 'http://www.makers.tech'
    end
  end

  describe ".delete" do
    it "deletes an entry from the bookmarks table" do
      db = PG.connect(dbname: 'bookmark_manager_test')
      db.exec("
        INSERT INTO bookmarks (url, title)
        VALUES('http://www.google.com', 'Google');")
      id = db.exec("
        INSERT INTO bookmarks (url, title)
        VALUES('http://www.makers.tech', 'Makers')
        RETURNING id;").first['id']
      expect(Bookmark.all.length).to eq 2
      Bookmark.delete(id: id)
      expect(Bookmark.all.length).to eq 1
    end
  end

  describe ".update" do
    it "deletes an entry from the bookmarks table" do
      db = PG.connect(dbname: 'bookmark_manager_test')

      bookmark = db.exec("
        INSERT INTO bookmarks (url, title)
        VALUES('http://www.makers.tech', 'Makers')
        RETURNING *;").first

      expect(Bookmark.all.length).to eq 1

      persisted_data = persisted_data(id: bookmark['id'])
      p bookmark['id']

      bookmark_updated = Bookmark.update(id: bookmark['id'], title: 'Makers', url: 'www.makersacademy.co.uk')

      expect(bookmark_updated.title).to eq 'Makers'
      expect(bookmark_updated.class).to eq Bookmark
      expect(bookmark_updated.id).to eq persisted_data['id']
      expect(bookmark_updated.url).to eq 'http://www.makersacademy.co.uk'
    end
  end

end
