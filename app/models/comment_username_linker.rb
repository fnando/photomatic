# frozen_string_literal: true

class CommentUsernameLinker
  def self.call(text, tagged_usernames)
    text.gsub(UsernameExtractor::REGEX) do |match|
      username = match[1..-1]
      url = Rails.application.routes.url_helpers.profile_path(username)
      valid_usernames = User.select(:username)
                            .where(username: tagged_usernames)
                            .map(&:username)

      if valid_usernames.include?(username)
        %[<a href="#{url}">#{match}</a>]
      else
        match
      end
    end
  end
end
