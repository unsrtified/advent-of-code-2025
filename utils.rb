# frozen_string_literal: true

module Utils
  module_function

  def read_lines(filename)
    File.read(filename).lines.map(&:chomp)
  end
end

module Enumerable
  def scan(initial)
    state = initial.dup
    map do |val|
      state = yield state, val
    end
  end
end
