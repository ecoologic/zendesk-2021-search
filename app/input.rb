# frozen_string_literal: true

class Input
  DEFAULTS = { field: '_id', query: '11' }.freeze

  def initialize(prompt = TTY::Prompt.new)
    @prompt = prompt
  end

  def model_type
    @model_type ||= prompt.select('Select the file to search', Models::BY_TYPE.keys, cycle: true).to_sym
  end

  def field
    @field ||= prompt.ask('Enter your search term', default: DEFAULTS[:field]).to_sym
  end

  def query
    @query ||= prompt.ask('Enter your search value')
  end

  private

  attr_reader :prompt
end
