class Bookmark

  attr_reader :id, :title, :url

  def self.all
    result = DatabaseConnection.query("SELECT * FROM bookmarks;")
    result.map do |bookmark|
      Bookmark.new(id: bookmark['id'], url: bookmark['url'], title: bookmark['title'])
    end
  end

  def self.create(url:, title:)
    return false unless Bookmark.validate_url?(url: url)
    result = DatabaseConnection.query("INSERT INTO bookmarks (url, title) VALUES('#{url}', '#{title}') RETURNING id, url, title;")[0]
    Bookmark.new(id: result['id'], url: result['url'], title: result['title'])
  end

  def self.delete(id:)
    DatabaseConnection.query("DELETE FROM bookmarks WHERE id = #{id}")
  end

  def self.update(id:, url:, title:)
    result = DatabaseConnection.query("UPDATE bookmarks SET url = '#{url}', title = '#{title}' WHERE id = '#{id}' RETURNING id, url, title;")[0]
    Bookmark.new(id: result['id'], url: result['url'], title: result['title'])
  end

  def self.find(id:)
    result = DatabaseConnection.query("SELECT * FROM bookmarks WHERE id = #{id}")[0]
    Bookmark.new(id: result['id'], url: result['url'], title: result['title'])
  end

  def initialize(id:, title:, url:)
    @id = id
    @title = title
    @url = url
  end

  private

  def self.validate_url?(url:)
    url =~ /\A#{URI::regexp(['http', 'https'])}\z/
  end

end
