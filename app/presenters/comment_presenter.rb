# frozen_string_literal: true

class CommentPresenter < Burgundy::Item
  def text
    @text ||= CommentUsernameLinker.call(
      CommentSanitizer.call(item.text).strip,
      tagged_user_ids
    )
  end

  def visible?
    !text.empty?
  end
end
