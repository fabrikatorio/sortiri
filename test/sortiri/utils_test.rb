# frozen_string_literal: true

require 'test_helper'

class Sortiri::UtilsTest < Minitest::Test
  def test_should_toggle_direction_and_icon_class_ascending_to_descending
    sort_string = '-id,name'
    column = :name

    sorter = Sortiri::Utils.new(sort_string: sort_string, column_name: column)

    assert_equal sorter.direction, '-'
    assert_equal sorter.icon_class, 'fas fa-angle-up'
  end

  def test_should_toggle_direction_and_icon_class_descending_to_ascending
    sort_string = '-id,name'
    column = :id

    sorter = Sortiri::Utils.new(sort_string: sort_string, column_name: column)

    assert_equal sorter.direction, ''
    assert_equal sorter.icon_class, 'fas fa-angle-down'
  end

  def test_should_return_empty_string_when_column_not_found
    sort_string = '-id,name'
    column = :quantity

    sorter = Sortiri::Utils.new(sort_string: sort_string, column_name: column)

    assert_kind_of Sortiri::MissingColumn, sorter.column
    assert_equal sorter.direction, ''
    assert_equal sorter.icon_class, ''
  end

  def test_should_work_same_for_a_foreign_column
    sort_string = '-id,product.name'
    column = 'product.name'

    sorter = Sortiri::Utils.new(sort_string: sort_string, column_name: column)

    assert_equal sorter.direction, '-'
    assert_equal sorter.icon_class, 'fas fa-angle-up'
  end
end
