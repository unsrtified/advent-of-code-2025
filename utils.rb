# frozen_string_literal: true

module Utils
  module_function

  def read_lines(filename)
    File.read(filename).lines.map(&:chomp)
  end
end
