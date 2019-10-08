feature "Add a bookmark" do
  scenario "User can add a site URL" do
    visit "/bookmarks/new"
    fill_in "url", with: "https://www.makers.tech"
    click_button "Submit"
    expect(page).to have_content("https://www.makers.tech")
  end
end
