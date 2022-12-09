# frozen_string_literal: true

module ActionView
  class TestCase
    def assert_html(expected, actual)
      expected = Nokogiri::HTML(expected)
      actual = Nokogiri::HTML(actual)

      assert expected.root, actual.root
    end
  end
end
