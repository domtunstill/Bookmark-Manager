feature "Add a bookmark" do
  scenario "User can add a site URL" do
    visit "/bookmarks/new"
    fill_in "url", with: "www.makers.tech"
    fill_in "title", with: "Makers"
    click_button "Submit"
    expect(page).to have_link("Makers", href: "http://www.makers.tech")
  end
end
