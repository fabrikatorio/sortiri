# frozen_string_literal: true

require 'test_helper'

class Sortiri::ModelTest < Minitest::Test
  def setup
    Temping.create :dummy_users do
      include Sortiri::Model

      belongs_to :dummy_company

      with_columns do |t|
        t.string :name
        t.integer :age
        t.integer :weight
        t.references :company
      end

      sortable against: %i[name age weight], associated_against: { dummy_company: [:name] }, default_sort: '-name'
    end

    Temping.create :dummy_company do
      has_many :dummy_user

      with_columns do |t|
        t.string :name
      end
    end
  end

  def teardown
    Temping.teardown
  end

  def test_check_if_model_methods_are_working_correctly
    assert_equal DummyUser.sortable_columns.count, 4
    assert_equal DummyUser.default_sort, '-name'

    column = DummyUser.sortable_columns[0]
    assert_kind_of Sortiri::ActiveRecord::Column, column
    assert_equal column.name, 'name'
    assert_nil column.association_name

    column = DummyUser.sortable_columns[1]
    assert_kind_of Sortiri::ActiveRecord::Column, column
    assert_equal column.name, 'age'
    assert_nil column.association_name

    column = DummyUser.sortable_columns[2]
    assert_kind_of Sortiri::ActiveRecord::Column, column
    assert_equal column.name, 'weight'
    assert_nil column.association_name

    column = DummyUser.sortable_columns[3]
    assert_kind_of Sortiri::ActiveRecord::ForeignColumn, column
    assert_equal column.name, 'name'
    assert_equal column.association_name, :dummy_company
  end

  def test_should_parse_everything_correctly
    # can parse multiple sort string
    assert_match(/dummy_users.age ASC,dummy_users.weight DESC/, DummyUser.sorted('age,-weight').to_sql)
    # can parse singular sort string
    assert_match(/dummy_users.age ASC/, DummyUser.sorted('age').to_sql)
    # should use default when nothing is given
    assert_match(/dummy_users.name DESC/, DummyUser.sorted(nil).to_sql)
    # can join tables if necessary
    assert_match(/LEFT OUTER JOIN "dummy_companies" ON "dummy_users"."dummy_company_id" = "dummy_companies"."id"/,
                 DummyUser.sorted('dummy_company.name').to_sql)
  end
end
