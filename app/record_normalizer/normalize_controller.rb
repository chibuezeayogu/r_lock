# frozen_string_literal: true

require_relative 'base'

class NormalizeController < Base
  attr_accessor :file, :separator

  def initialize(file, separator)
    super
    @file = file
    @separator = separator
  end

  def process
    transform
  end
end
