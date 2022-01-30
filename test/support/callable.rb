# frozen_string_literal: true

class Callable
  attr_reader :calls

  def initialize
    @calls = []
  end

  def to_proc
    proc {|*args| calls << args }
  end

  def called?
    !calls.empty?
  end

  def called_exactly?(count)
    calls.size == count
  end
end
