require 'pg'

class Bookmark

  attr_reader :id, :title, :url

  def self.all
    if ENV['ENVIRONMENT'] == 'test'
      db = PG.connect(dbname: 'bookmark_manager_test')
    else
      db = PG.connect(dbname: 'bookmark_manager')
    end
    result = db.exec("SELECT * FROM bookmarks;")
    result.map do |bookmark|
      Bookmark.new(id: bookmark['id'], url: bookmark['url'], title: bookmark['title'])
    end
  end

  def self.create(url:, title:)
    if ENV['ENVIRONMENT'] == 'test'
      db = PG.connect(dbname: 'bookmark_manager_test')
    else
      db = PG.connect(dbname: 'bookmark_manager')
    end
    result = db.exec("INSERT INTO bookmarks (url, title) VALUES('http://#{url}', '#{title}') RETURNING id, url, title;")
    Bookmark.new(id: result[0]['id'], url: result[0]['url'], title: result[0]['title'])
  end

  def self.delete(id:)
    if ENV['ENVIRONMENT'] == 'test'
      db = PG.connect(dbname: 'bookmark_manager_test')
    else
      db = PG.connect(dbname: 'bookmark_manager')
    end
    db.exec("DELETE FROM bookmarks WHERE id = #{id}")
  end

  def self.update(id:, url:, title:)
    exisiting_bookmark = Bookmark.find(id: id)
    return false if Bookmark.same_object?(url, exisiting_bookmark.url) && Bookmark.same_object?(title, exisiting_bookmark.title)

    if ENV['ENVIRONMENT'] == 'test'
      db = PG.connect(dbname: 'bookmark_manager_test')
    else
      db = PG.connect(dbname: 'bookmark_manager')
    end

    result = db.exec("UPDATE bookmarks SET url = 'http://#{url}', title = '#{title}' WHERE id = '#{id}' RETURNING id, url, title;")
    Bookmark.new(id: result[0]['id'], url: result[0]['url'], title: result[0]['title'])
  end

  def self.find(id:)
    if ENV['ENVIRONMENT'] == 'test'
      db = PG.connect(dbname: 'bookmark_manager_test')
    else
      db = PG.connect(dbname: 'bookmark_manager')
    end
    result = db.exec("SELECT * FROM bookmarks WHERE id = #{id}")
    Bookmark.new(id: result[0]['id'], url: result[0]['url'], title: result[0]['title'])
  end

  private

  def self.same_object?(new, old)
    new == old
  end

  public

  def initialize(id:, title:, url:)
    @id = id
    @title = title
    @url = url
  end

end
