# frozen_string_literal: true

module Utils
  module_function

  def read_lines(filename)
    File.read(filename).lines.map(&:chomp)
  end
end

class Numeric
  def min(other) = self <= other ? self : other
end

class String
  def to_ints(sep = ",") = split(sep).map(&:to_i)
end

class Array
  def every_combination = (1..size).reduce([]) { _1.chain(combination(_2)) }.to_enum

  def update_at(*specifiers)
    specifiers.each { self[it] = yield self[it] }
    self
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
