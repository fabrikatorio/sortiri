# frozen_string_literal: true

require 'test_helper'

class Sortiri::ColumnTest < Minitest::Test
  def test_column_name_with_minus_sign
    column = Sortiri::Column.new(column: '-id')

    assert_equal column.name, 'id'
    assert_equal column.name_with_association, 'id'
    assert_equal column.name_with_sign, '-id'
    assert_nil column.association
    assert_equal column.direction, '-'
    assert_equal column.direction_sql, 'DESC'
    assert_equal column.asc?, false
    assert_equal column.desc?, true
    assert_equal column.foreign_column?, false
    assert_equal column.toggle_direction, ''
    assert_equal column.toggle_icon_class, 'fas fa-angle-down'
  end

  def test_column_name_without_sign
    column = Sortiri::Column.new(column: 'id')

    assert_equal column.name, 'id'
    assert_equal column.name_with_association, 'id'
    assert_equal column.name_with_sign, 'id'
    assert_nil column.association
    assert_equal column.direction, ''
    assert_equal column.direction_sql, 'ASC'
    assert_equal column.asc?, true
    assert_equal column.desc?, false
    assert_equal column.foreign_column?, false
    assert_equal column.toggle_direction, '-'
    assert_equal column.toggle_icon_class, 'fas fa-angle-up'
  end

  def test_foreign_column_name_with_minus_sign
    column = Sortiri::Column.new(column: '-product.id')

    assert_equal column.name, 'id'
    assert_equal column.name_with_association, 'product.id'
    assert_equal column.name_with_sign, '-product.id'
    assert_equal column.association, 'product'
    assert_equal column.direction, '-'
    assert_equal column.direction_sql, 'DESC'
    assert_equal column.asc?, false
    assert_equal column.desc?, true
    assert_equal column.foreign_column?, true
    assert_equal column.toggle_direction, ''
    assert_equal column.toggle_icon_class, 'fas fa-angle-down'
  end

  def test_foreign_column_name_without_sign
    column = Sortiri::Column.new(column: 'product.id')

    assert_equal column.name, 'id'
    assert_equal column.name_with_association, 'product.id'
    assert_equal column.name_with_sign, 'product.id'
    assert_equal column.association, 'product'
    assert_equal column.direction, ''
    assert_equal column.direction_sql, 'ASC'
    assert_equal column.asc?, true
    assert_equal column.desc?, false
    assert_equal column.foreign_column?, true
    assert_equal column.toggle_direction, '-'
    assert_equal column.toggle_icon_class, 'fas fa-angle-up'
  end
end
