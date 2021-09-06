# frozen_string_literal: true

require 'date'

class Base
  STATES = {
    'LA' => 'Los Angeles',
    'NYC' => 'New York City'
  }.freeze

  def initialize(file, separator)
    @file = file
    @seperator = separator
  end

  def transform
    peoples = []
    keys = []
    @file.each_line.with_index do |line, i|
      if i.zero?
        keys = format_line(line) if i.zero?
      else
        value = format_line(line)
        peoples << user_info(keys, value)
      end
    end
    peoples
  end

  private

  attr_accessor :file, :separator

  def format_line(line)
    line.split(@separator).map(&:strip)
  end

  def user_info(keys, value)
    user_info = {}
    keys.each_with_index do |key, i|
      user_info[key] = case key
                       when 'birthdate'
                         format_birthdate(value[i])
                       when 'city'
                         format_state(value[i])
                       else
                         value[i]
                       end
    end
    user_info
  end

  def format_birthdate(val)
    DateTime.parse(val).strftime('%-m/%-d/%Y')
  end

  def format_state(val)
    STATES.keys.include?(val) ? STATES[val] : val
  end
end
