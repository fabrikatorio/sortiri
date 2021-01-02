# frozen_string_literal: true

require 'test_helper'

class Sortiri::MissingColumnTest < Minitest::Test
  def test_should_respond_mandatory_method_calls
    column = Sortiri::MissingColumn.new

    # default Sortiri::Column behavior
    assert_equal column.name, 'no name'
    assert_equal column.name_with_sign, 'no name'
    assert_equal column.name_with_association, 'no name'
    assert_nil column.association
    # overriden Sortiri::Column methods and attributes
    # remember MissingColumn has no direction or sql related property
    assert_equal column.direction, ''
    assert_equal column.direction_sql, ''
    assert_equal column.asc?, false
    assert_equal column.desc?, false
    assert_equal column.foreign_column?, false
    assert_equal column.toggle_direction, ''
    assert_equal column.toggle_icon_class, ''
  end
end
