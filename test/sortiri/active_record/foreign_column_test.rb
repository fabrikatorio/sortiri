# frozen_string_literal: true

require 'test_helper'

class Sortiri::ActiveRecord::ForeignColumnTest < Minitest::Test
  def test_column_attributes_and_methods
    model = mock

    association = mock
    model.expects(:reflect_on_association).at_least_once.returns(association)
    association.expects(:table_name).at_least_once.returns('table_name')
    association.expects(:foreign_key).returns('foreign_key')

    column = Sortiri::ActiveRecord::ForeignColumn.new(name: 'created_at', model: model, association_name: :product)

    assert_equal column.name, 'created_at'
    assert_equal column.association_name, :product
    assert_equal column.table_name, 'table_name'
    assert_equal column.foreign_key, 'foreign_key'
    assert_equal column.name_with_table_name, 'table_name.created_at'
    assert_equal column.matches_with?(Sortiri::Column.new(column: 'product.created_at')), true
    assert_equal column.matches_with?(Sortiri::Column.new(column: 'company.created_at')), false
    assert_equal column.matches_with?(Sortiri::Column.new(column: 'created_at1')), false
    assert_equal column.matches_with?({}), false
  end
end
