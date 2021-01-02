# frozen_string_literal: true

require 'test_helper'

class Sortiri::ActiveRecord::ColumnTest < Minitest::Test
  def test_column_attributes_and_methods
    column = Sortiri::ActiveRecord::Column.new(name: 'description', model: OpenStruct.new(table_name: 'table_name'))

    assert_equal column.name, 'description'
    assert_nil column.association_name
    assert_equal column.table_name, 'table_name'
    assert_equal column.name_with_table_name, 'table_name.description'
    assert_equal column.matches_with?(Sortiri::Column.new(column: 'description')), true
    assert_equal column.matches_with?(Sortiri::Column.new(column: 'company.description')), false
    assert_equal column.matches_with?(Sortiri::Column.new(column: 'description1')), false
    assert_equal column.matches_with?({}), false
  end
end
