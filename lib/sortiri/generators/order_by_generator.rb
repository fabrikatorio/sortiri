# frozen_string_literal: true

module Sortiri
  module Generators
    class OrderByGenerator
      attr_reader :sortable_columns, :whitelisted_columns, :columns_hash, :foreign_columns

      def initialize(sortable_columns:, whitelisted_columns:)
        @sortable_columns = sortable_columns # array of Sortiri::ActiveRecord::Column
        @whitelisted_columns = whitelisted_columns # array of Sortiri::Column
        @columns_hash = map_columns_and_active_record_columns
        @foreign_columns = select_unique_foreign_columns
      end

      def sort(model, reorder: false)
        query = if reorder
                  model.reorder(generate_order_by_clauses)
                else
                  model.order(generate_order_by_clauses)
                end
        query = query.joins(generate_joins(model)) if needs_join?
        query
      end

      private

      def needs_join?
        foreign_columns.present?
      end

      def generate_order_by_clauses
        columns_hash.map do |column_hash|
          concatenate_column_and_direction(column_hash)
        end.join(',')
      end

      def generate_joins(model)
        source_arel_table = model.arel_table

        foreign_columns.map do |hash|
          active_record_column = hash[:active_record_column]
          target_arel_table = Arel::Table.new(active_record_column.table_name)

          # TODO: find a way to get primary key from target_arel_table
          source_arel_table.join(target_arel_table, Arel::Nodes::OuterJoin).
            on(source_arel_table[active_record_column.foreign_key.to_sym].eq(target_arel_table[:id]))
        end.map(&:join_sources)
      end

      def concatenate_column_and_direction(column_hash)
        Arel.sql("#{column_hash[:active_record_column].name_with_table_name} #{column_hash[:column].direction_sql}")
      end

      def map_columns_and_active_record_columns
        whitelisted_columns.map do |column|
          sortable_column = sortable_columns.detect { |c| c.matches_with?(column) }

          { active_record_column: sortable_column, column: column }
        end
      end

      def select_unique_foreign_columns
        columns_hash.select { |c| c[:active_record_column].is_a?(Sortiri::ActiveRecord::ForeignColumn) }.
          uniq { |c| c[:active_record_column].association_name }
      end
    end
  end
end
