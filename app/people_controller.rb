# frozen_string_literal: true

require_relative 'record_normalizer/normalize_controller'

class PeopleController
  KEYS = %w[first_name city birthdate].freeze

  def initialize(params)
    @params = params
  end

  def normalize
    dollar_format = process(@params[:dollar_format], '$')
    percent_format = process(@params[:percent_format], '%')
    people = dollar_format + percent_format
    sort_result(people, sort_order)
  end

  private

  attr_reader :params

  def process(file, separator)
    NormalizeController
      .new(file, separator)
      .process
  end

  def sort_result(people, _order)
    people
      .sort_by { |k, _v| k[sort_order] }
      .map! { |h| h.slice(*KEYS).values.join(', ') }
  end

  def sort_order
    @params[:order].to_s
  end
end
