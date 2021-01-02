# frozen_string_literal: true

require 'active_record'
require 'active_support/concern'

require 'sortiri/version'
require 'sortiri/configuration'

require 'sortiri/active_record/column'
require 'sortiri/active_record/foreign_column'
require 'sortiri/generators/order_by_generator'
require 'sortiri/view_helpers/table_sorter'
require 'sortiri/column'
require 'sortiri/missing_column'
require 'sortiri/model'
require 'sortiri/parser'
require 'sortiri/utils'

module Sortiri
  class << self
    def configuration
      @configuration ||= Configuration.new
    end

    def configure
      yield(configuration)
    end
  end
end
