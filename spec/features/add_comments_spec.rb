feature "Add a comment to a bookmark" do

  scenario "User can add comments to a saved bookmark" do
    visit "/bookmarks"
    first('.comments').click_link "Add/Edit Comments"
    fill_in "comment", with: "Legendary coding school"
    click_button "Add"
    click_button "Submit"
    expect(page).to have_content("Legendary coding school")
  end

end
