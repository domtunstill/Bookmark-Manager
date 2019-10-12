feature "Add a bookmark" do

  scenario "User can add a site URL and title" do
    visit "/bookmarks/new"
    fill_in "url", with: "http://www.makers.tech"
    fill_in "title", with: "Makers"
    click_button "Submit"
    expect(page).to have_link("Makers", href: "http://www.makers.tech")
  end

  scenario "User can add comment to the bookmark on saving a new bookmark" do
    visit "/bookmarks/new"
    fill_in "url", with: "http://www.makers.tech"
    fill_in "title", with: "Makers"
    fill_in "comment", with: "Legendary coding school"
    click_button "Submit"
    expect(page).to have_content("Legendary coding school")
  end

  scenario 'it returns a message to user if URL format is not correct' do
    visit('/bookmarks/new')
    fill_in('url', with: 'randomcat')
    fill_in('title', with: 'cat')
    click_button('Submit')

    expect(page).to have_content('Invalid URL')
  end

end
