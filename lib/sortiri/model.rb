# frozen_string_literal: true

module Sortiri
  module Model
    extend ActiveSupport::Concern

    module ClassMethods
      attr :sortable_columns, :default_sort

      def sortable(against:, default_sort:, associated_against: {})
        @sortable_columns ||= []

        columns = against.map do |column|
          Sortiri::ActiveRecord::Column.new(name: column, model: self)
        end

        association_columns = associated_against.map do |association_name, columns_array|
          columns_array.map do |column|
            Sortiri::ActiveRecord::ForeignColumn.new(name: column, model: self, association_name: association_name)
          end
        end.flatten

        @sortable_columns = columns + association_columns
        @default_sort = default_sort
      end

      def parse_sorting(sort_query_string)
        sort_string = (sort_query_string.presence || default_sort)
        whitelisted_columns = Sortiri::Parser.new(sortable_columns: sortable_columns, sort_string: sort_string).whitelisted_columns
        Sortiri::Generators::OrderByGenerator.new(sortable_columns: sortable_columns, whitelisted_columns: whitelisted_columns)
      end

      # sort_query_string is a string seperated by comma and takes - sign
      # when it's descending. all of the examples below are valid.
      # request => GET /users?sort=-id,name,email || params => '-id,name,email'
      # request => GET /users?sort=name,email || params => 'name,email'
      # request => GET /users || params => nil
      def sorted(sort_query_string = nil)
        generator = parse_sorting(sort_query_string)
        generator.sort(self)
      end

      # this function will override order by clauses which defined
      # before sorted! call and force them to use its way.
      # every example above are still valid for this function.
      def sorted!(sort_query_string = nil)
        generator = parse_sorting(sort_query_string)
        generator.sort(self, reorder: true)
      end
    end
  end
end
