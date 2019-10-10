class Bookmark

  attr_reader :id, :title, :url

  def self.all
    result = DatabaseConnection.query("SELECT * FROM bookmarks;")
    result.map do |bookmark|
      Bookmark.new(id: bookmark['id'], url: bookmark['url'], title: bookmark['title'])
    end
  end

  def self.create(url:, title:)
    result = DatabaseConnection.query("INSERT INTO bookmarks (url, title) VALUES('http://#{url}', '#{title}') RETURNING id, url, title;")
    Bookmark.new(id: result[0]['id'], url: result[0]['url'], title: result[0]['title'])
  end

  def self.delete(id:)
    DatabaseConnection.query("DELETE FROM bookmarks WHERE id = #{id}")
  end

  def self.update(id:, url:, title:)
    exisiting_bookmark = Bookmark.find(id: id)
    return false if Bookmark.same_object?(url, exisiting_bookmark.url) && Bookmark.same_object?(title, exisiting_bookmark.title)

    result = DatabaseConnection.query("UPDATE bookmarks SET url = 'http://#{url}', title = '#{title}' WHERE id = '#{id}' RETURNING id, url, title;")
    Bookmark.new(id: result[0]['id'], url: result[0]['url'], title: result[0]['title'])
  end

  def self.find(id:)
    result = DatabaseConnection.query("SELECT * FROM bookmarks WHERE id = #{id}")
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
