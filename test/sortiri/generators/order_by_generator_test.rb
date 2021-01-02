# frozen_string_literal: true

require 'test_helper'

class Sortiri::Generators::OrderByGeneratorTest < Minitest::Test
  def test_columns_hash_attribute
    active_record_column1 = Sortiri::ActiveRecord::Column.new(name: 'id', model: mock)
    active_record_column2 = Sortiri::ActiveRecord::ForeignColumn.new(name: 'description', model: mock, association_name: 'product')
    sortable_columns = [active_record_column1, active_record_column2]

    column1 = Sortiri::Column.new(column: '-id')
    column2 = Sortiri::Column.new(column: 'product.description')
    whitelisted_columns = [column1, column2]

    generator = Sortiri::Generators::OrderByGenerator.new(sortable_columns: sortable_columns,
                                                        whitelisted_columns: whitelisted_columns)

    assert_equal generator.columns_hash.count, 2

    column_hash = generator.columns_hash[0]
    assert_kind_of Sortiri::ActiveRecord::Column, column_hash[:active_record_column]
    assert_kind_of Sortiri::Column, column_hash[:column]
    assert_equal active_record_column1, column_hash[:active_record_column]
    assert_equal column1, column_hash[:column]

    column_hash = generator.columns_hash[1]
    assert_kind_of Sortiri::ActiveRecord::ForeignColumn, column_hash[:active_record_column]
    assert_kind_of Sortiri::Column, column_hash[:column]
    assert_equal active_record_column2, column_hash[:active_record_column]
    assert_equal column2, column_hash[:column]
  end

  def test_foreign_columns_attribute
    active_record_column1 = Sortiri::ActiveRecord::Column.new(name: 'id', model: mock)
    active_record_column2 = Sortiri::ActiveRecord::ForeignColumn.new(name: 'description', model: mock, association_name: 'product')
    sortable_columns = [active_record_column1, active_record_column2]

    column1 = Sortiri::Column.new(column: '-id')
    column2 = Sortiri::Column.new(column: 'product.description')
    whitelisted_columns = [column1, column2]

    generator = Sortiri::Generators::OrderByGenerator.new(sortable_columns: sortable_columns,
                                                        whitelisted_columns: whitelisted_columns)

    assert_equal generator.foreign_columns.count, 1

    column_hash = generator.foreign_columns[0]
    assert_kind_of Sortiri::ActiveRecord::ForeignColumn, column_hash[:active_record_column]
    assert_kind_of Sortiri::Column, column_hash[:column]
    assert_equal active_record_column2, column_hash[:active_record_column]
    assert_equal column2, column_hash[:column]
  end
end
