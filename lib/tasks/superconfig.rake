# frozen_string_literal: true

desc "Show SuperConfig report"
task superconfig: [:environment] do
  puts Photomatic::Config.report
end
