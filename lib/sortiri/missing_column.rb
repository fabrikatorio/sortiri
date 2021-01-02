# frozen_string_literal: true

module Sortiri
  class MissingColumn < Sortiri::Column
    def initialize
      super(column: 'no name')
    end

    def direction
      ''
    end

    def direction_sql
      ''
    end

    def asc?
      false
    end

    def desc?
      false
    end

    def toggle_direction
      ''
    end

    def toggle_icon_class
      ''
    end

    def foreign_column?
      false
    end
  end
end
