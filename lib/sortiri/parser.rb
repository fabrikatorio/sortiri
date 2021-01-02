# frozen_string_literal: true

module Sortiri
  class Parser
    DELIMITER = ','

    attr_reader :sortable_columns, :sort_string

    def initialize(sortable_columns:, sort_string:)
      @sortable_columns = sortable_columns # Array of Sortiri::ActiveRecord::Column
      @sort_string = sort_string
    end

    def whitelisted_columns
      columns = self.class.parse(sort_string: sort_string)

      columns.select do |column|
        sortable_columns.any? { |c| c.matches_with?(column) }
      end
    end

    def self.parse(sort_string:)
      return [] if sort_string.blank?

      sort_string.split(DELIMITER).map do |s|
        Sortiri::Column.new(column: s)
      end
    end
  end
end
