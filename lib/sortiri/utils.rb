# frozen_string_literal: true

module Sortiri
  class Utils
    attr_reader :sort_string, :column_name, :column

    def initialize(sort_string:, column_name:)
      @sort_string = sort_string
      @column_name = column_name.to_s
      @column = find_column
    end

    def direction
      column.toggle_direction
    end

    def icon_class
      column.toggle_icon_class
    end

    private

    def find_column
      columns = Sortiri::Parser.parse(sort_string: sort_string)
      columns.detect { |column| column.name_with_association == column_name } || MissingColumn.new
    end
  end
end
