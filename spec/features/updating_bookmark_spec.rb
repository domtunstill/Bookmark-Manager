feature 'Update bookmarks' do
  scenario 'can update a bookmark from the list of bookmarks' do
    # Add the test data
    Bookmark.create(url: 'http://www.makers.tech', title: 'Makers')
    visit('/bookmarks')
    expect(page).to have_link('Makers', href: 'http://www.makers.tech')
    first('.bookmark').click_button "Edit"

    fill_in "url", with: "http://www.google.com"
    fill_in "title", with: "Google"
    click_button "Submit"

    expect(current_path).to eq '/bookmarks'
    expect(page).not_to have_link('Makers', href: 'http://www.makers.tech')
    expect(page).to have_link('Google', href: 'http://www.google.com')

  end
end
