# frozen_string_literal: true

module ApplicationSystemTestHelpers
  def click_email_link(index, mail = ActionMailer::Base.deliveries.last)
    html = Nokogiri(mail.html_part.body.to_s)
    link = html.css("a").to_a[index]

    refute_nil link, "Couldn't find a link index=#{index.inspect}"
    refute_nil link["href"], "Link didn't have :href attribute"

    visit link["href"]
  end

  def page_title(scope)
    I18n.t(scope, scope: "page_meta.titles")
  end
end
