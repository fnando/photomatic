# frozen_string_literal: true

require "test_helper"

class UsernameExtractorTest < ActiveSupport::TestCase
  [
    ["", []],
    ["@john you should check this! @Mary123!", %w[john Mary123]],
    ["@_john__", []],
    ["@_john", []],
    ["@john__doe", []],
    ["@john__", []],
    ["@john @JOHN @John", ["john"]]
  ].each do |(input, output)|
    test "extracts #{output.inspect} out of #{input.inspect}" do
      assert_equal output, UsernameExtractor.call(input)
    end
  end
end
