# frozen_string_literal: true

require "application_system_test_case"

class AuthTest < ApplicationSystemTestCase
  include ActiveJob::TestHelper

  test "signs up to the website" do
    visit root_path
    click_on t("home.index.create_your_account")
    fill_in field("login.email"), with: "john@photomatic.app"
    click_on button("login.create")

    assert_selector "p", text: t("login.check_inbox.check_your_inbox")

    perform_enqueued_jobs

    I18n.t("verify_your_email")
    click_email_link(0)

    assert_equal root_path, current_path
    assert_selector "span.username", text: User.last.username
  end
end
