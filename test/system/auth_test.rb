# frozen_string_literal: true

require "application_system_test_case"

class AuthTest < ApplicationSystemTestCase
  include ActiveJob::TestHelper

  test "signs up to the website" do
    visit root_path
    click_on t("home.index.create_your_account")
    fill_in field("login.email"), with: "john@photomatic.app"
    click_on button("login.create")

    assert_equal check_inbox_path, current_path
    assert_selector "p", text: page_title("login.check_inbox")

    perform_enqueued_jobs

    click_email_link(0)

    assert_equal root_path, current_path
  end

  test "rejects signups with invalid data" do
    visit root_path
    click_on t("home.index.create_your_account")
    fill_in field("login.email"), with: "john@dispostable.com"
    click_on button("login.create")

    assert_equal login_path, current_path
    assert_selector ".field-error",
                    text: t("activemodel.errors.messages.disposable_domain")
  end

  test "using invalid verification link" do
    visit verify_email_url

    assert_equal login_path, current_path
    assert_selector ".flash-message", text: t("flash.login.verify_email.alert")
  end
end
