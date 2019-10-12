require 'comment'

describe Comment do

  describe '.create' do
    it 'creates a comment instance and saves it to the comments table' do
      db = PG.connect(dbname: 'bookmark_manager_test')
      bookmark_id = db.exec("
        INSERT INTO bookmarks (url, title)
        VALUES('http://www.google.com', 'Google') RETURNING id;")[0]['id']
      comment = Comment.create(bookmark_id: bookmark_id, contents: "Legendary coding school")
      persisted_data = persisted_data(id: comment.id, table: 'comments')
      expect(comment.class).to eq Comment
      expect(comment.id).to eq persisted_data['id']
      expect(comment.bookmark_id).to eq bookmark_id
      expect(comment.contents).to eq "Legendary coding school"
    end
  end

  describe '.where' do
    it 'returns a list of bookmarks' do
      db = PG.connect(dbname: 'bookmark_manager_test')
      bookmark_id = db.exec("
        INSERT INTO bookmarks (url, title)
        VALUES('http://www.makers.tech', 'Makers')
        RETURNING id;").first['id']
      db.exec("
        INSERT INTO comments (bookmark_id, contents)
        VALUES('#{bookmark_id}', 'Legendary coding school');")
      comments = Comment.where(bookmark_id: bookmark_id)
      expect(comments.length).to eq 1
      expect(comments.first).to be_a Comment
      expect(comments.first.bookmark_id).to eq bookmark_id
      expect(comments.first.contents).to eq 'Legendary coding school'
    end
  end

end
