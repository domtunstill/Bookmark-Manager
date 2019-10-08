feature 'View bookmarks' do
  scenario 'can view a list of bookmarks' do

    # Add the test data
    Bookmarks.create('http://www.google.com')

    visit('/bookmarks')
    expect(page).to have_content 'Bookmarks'
    expect(page).to have_content 'http://www.google.com'
  end
end
