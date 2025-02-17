feature 'View bookmarks' do
  scenario 'can view a list of bookmarks' do

    # Add the test data
    Bookmark.create(url: 'http://www.makers.tech', title: 'Makers')

    visit('/')
    expect(page).to have_content 'Bookmarks'
    expect(page).to have_link('Makers', href: 'http://www.makers.tech')
  end
end
