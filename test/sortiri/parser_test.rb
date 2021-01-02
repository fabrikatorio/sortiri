# frozen_string_literal: true

require 'test_helper'

class Sortiri::ParserTest < Minitest::Test
  def test_parser_should_return_columns_which_exist_in_sortable_columns
    column1 = Sortiri::ActiveRecord::Column.new(name: 'description', model: mock)
    column2 = Sortiri::ActiveRecord::ForeignColumn.new(name: 'quantity', model: mock, association_name: 'product')
    sortable_columns = [column1, column2]
    sort_string = '-name,description,-product.quantity' # name is not allowed

    whitelisted_columns = Sortiri::Parser.new(sortable_columns: sortable_columns, sort_string: sort_string).whitelisted_columns

    assert_equal whitelisted_columns.count, 2
    assert_kind_of Sortiri::Column, whitelisted_columns[0]
    assert_equal 'description', whitelisted_columns[0].name
    assert_kind_of Sortiri::Column, whitelisted_columns[1]
    assert_equal 'quantity', whitelisted_columns[1].name
  end

  def test_parser_should_parse_everything_we_give
    sort_string = '-name,description,-product.quantity'

    parsed_columns = Sortiri::Parser.parse(sort_string: sort_string)

    assert_equal parsed_columns.count, 3
    assert_kind_of Sortiri::Column, parsed_columns[0]
    assert_equal 'name', parsed_columns[0].name
    assert_kind_of Sortiri::Column, parsed_columns[1]
    assert_equal 'description', parsed_columns[1].name
    assert_kind_of Sortiri::Column, parsed_columns[2]
    assert_equal 'quantity', parsed_columns[2].name
  end

  def test_parser_should_return_empty_array_if_sort_string_is_empty
    parsed_columns = Sortiri::Parser.parse(sort_string: '')

    assert_equal parsed_columns, []
  end
end
