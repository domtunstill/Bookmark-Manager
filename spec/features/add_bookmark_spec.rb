feature "Add a bookmark" do
  scenario "User can add a site URL" do
    visit "/bookmarks/new"
    fill_in "url", with: "http://www.makers.tech"
    fill_in "title", with: "Makers"
    click_button "Submit"
    expect(page).to have_link("Makers", href: "http://www.makers.tech")
  end

  scenario 'it returns a message to user if URL format is not correct' do
    visit('/bookmarks/new')
    fill_in('url', with: 'randomcat')
    fill_in('title', with: 'cat')
    click_button('Submit')

    expect(page).to have_content('Invalid URL')
  end

end
