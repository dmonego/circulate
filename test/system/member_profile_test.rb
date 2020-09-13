require "application_system_test_case"

class MemberProfileTest < ApplicationSystemTestCase
  def setup
    @member = create(:verified_member_with_membership)
    @user = create(:user, member: @member)
    login_as @user
  end

  test "member can view profile" do
    visit member_profile_url

    assert_content @member.full_name
    assert_content @member.number
    assert_button "Edit Member Profile"
  end

  test "member can edit profile" do
    visit member_profile_url
    click_button "Edit Member Profile"

    fill_in "Full name", with: "Updated Name"
    click_on "Update Member"
    assert_content "Updated Name"
  end

  test "member sees validation errors on update failure" do
    visit member_profile_url
    click_button "Edit Member Profile"

    fill_in "Full name", with: ""
    click_on "Update Member"
    assert_content "Please correct the errors below!"
    # Ensure that the error message for the correct field is displayed
    assert_equal "can't be blank", page.find("label", text: "Full name").sibling(".form-input-hint").text
  end
end
