feature "Add a bookmark" do
  scenario "User can add a site URL" do
    visit "/bookmarks/new"
    fill_in "url", with: "https://www.makers.tech"
    fill_in "title", with: "Makers"
    click_button "Submit"
    expect(page).to have_link("Makers", href: "https://www.makers.tech")
  end
end
