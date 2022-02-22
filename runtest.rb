# frozen_string_literal: true

require "listen"
require "pathname"
require "shellwords"

class Runtest
  attr_reader :root_dir, :watchers

  def initialize(root_dir = Dir.pwd)
    @root_dir = Pathname.new(root_dir)
    @watchers = []
  end

  def start
    listener = Listen.to(
      root_dir.to_s,
      ignore: [%r{(public|node_modules|assets)/}]
    ) do |modified, added, removed|
      modified = convert_to_relative_paths(modified)
      added = convert_to_relative_paths(added)
      removed = convert_to_relative_paths(removed)

      watchers.each do |watcher|
        run_watcher(watcher, modified:, added:, removed:)
      end
    end

    listener.start

    sleep
  end

  def run_watcher(watcher, modified:, added:, removed:)
    paths = []
    paths += modified if watcher[:on].include?(:modified)
    paths += added if watcher[:on].include?(:added)
    paths += removed if watcher[:on].include?(:removed)
    paths = paths.select {|path| path.to_s.match?(watcher[:pattern]) }

    return unless paths.any?

    watcher[:thread]&.kill
    watcher[:thread] = Thread.new { watcher[:command].call(paths) }
  end

  def watch(watcher)
    watchers << watcher
  end

  def convert_to_relative_paths(paths)
    paths.map {|file| Pathname.new(file).relative_path_from(root_dir) }
  end
end

runtest = Runtest.new

runtest.watch(
  on: %i[modified added],
  pattern: %r{^(app|test)/.+\.rb$},
  command: lambda do |paths|
    test_paths = paths.filter_map do |path|
      path = path.to_s.gsub(%r{^app/}, "test/")
      path = File.join(
        File.dirname(path),
        "#{File.basename(path.gsub(/(_test)?\.rb$/, ''))}_test.rb"
      )

      path = Pathname.new(path)

      path if path.file?
    end

    next if test_paths.empty?

    command = ["bundle", "exec", "rails", "test", *test_paths.map(&:to_s)]

    system("clear")
    puts [
      "\e[37m$",
      *command.map {|arg| Shellwords.shellescape(arg) },
      "\e[0m"
    ].join(" ")
    system(*command)
  end
)

runtest.start
