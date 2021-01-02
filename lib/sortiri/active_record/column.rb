# frozen_string_literal: true

module Sortiri
  module ActiveRecord
    class Column
      attr_reader :name, :association_name

      def initialize(name:, model:, association_name: nil)
        @name = name.to_s
        @model = model
        @association_name = association_name
      end

      def name_with_table_name
        [table_name, name].join('.')
      end

      def matches_with?(column_object)
        return false unless column_object.is_a?(Sortiri::Column)

        name == column_object.name && association_name.to_s == column_object.association.to_s
      end

      def table_name
        @model.table_name
      end
    end
  end
end
