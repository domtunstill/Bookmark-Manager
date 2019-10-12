class Comment

  attr_reader :id, :bookmark_id, :contents

  def self.create(bookmark_id:, contents:)
    result = DatabaseConnection.query("INSERT INTO comments (bookmark_id, contents) VALUES('#{bookmark_id}', '#{contents}') RETURNING id, bookmark_id, contents;")[0]
    Comment.new(id: result['id'], bookmark_id: result['bookmark_id'], contents: result['contents'])
  end

  def self.where(bookmark_id:)
    result = DatabaseConnection.query("SELECT * FROM comments WHERE bookmark_id = #{bookmark_id};")
    result.map do |comment|
      Comment.new(id: comment['id'], bookmark_id: comment['bookmark_id'], contents: comment['contents'])
    end
  end

  def initialize(id:, bookmark_id:, contents:)
    @id = id
    @bookmark_id = bookmark_id
    @contents = contents
  end

end
