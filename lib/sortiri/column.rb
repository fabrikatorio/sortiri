# frozen_string_literal: true

module Sortiri
  class Column
    ASCENDING_SIGN = ''
    DESCENDING_SIGN = '-'
    ASCENDING_SQL = 'ASC'
    DESCENDING_SQL = 'DESC'
    ASSOCIATION_DELIMITER = '.'

    attr_reader :name_with_sign

    def initialize(column:)
      @name_with_sign = column.to_s
    end

    def name
      raw_name = name_with_sign
      raw_name = raw_name[1..] if raw_name.start_with?(DESCENDING_SIGN)
      raw_name = raw_name.split(ASSOCIATION_DELIMITER)[1] if foreign_column?

      raw_name
    end

    def name_with_association
      return [association, name].join(ASSOCIATION_DELIMITER) if foreign_column?

      name
    end

    def association
      return unless foreign_column?

      # name might have '-' sign, delete_prefix removes that
      # if no sign in there, it just returns the whole string
      name_with_sign.delete_prefix(DESCENDING_SIGN).split(ASSOCIATION_DELIMITER).first
    end

    def direction
      return DESCENDING_SIGN if name_with_sign.start_with?(DESCENDING_SIGN)

      ASCENDING_SIGN
    end

    def direction_sql
      return DESCENDING_SQL if direction == DESCENDING_SIGN

      ASCENDING_SQL
    end

    def toggle_direction
      return ASCENDING_SIGN if desc?

      DESCENDING_SIGN
    end

    def toggle_icon_class
      return Sortiri.configuration.down_arrow if desc?

      Sortiri.configuration.up_arrow
    end

    def asc?
      direction == ASCENDING_SIGN
    end

    def desc?
      direction == DESCENDING_SIGN
    end

    def foreign_column?
      name_with_sign.include?(ASSOCIATION_DELIMITER)
    end
  end
end
