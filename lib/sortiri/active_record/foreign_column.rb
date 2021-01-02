# frozen_string_literal: true

module Sortiri
  module ActiveRecord
    class ForeignColumn < Column
      def initialize(name:, model:, association_name:)
        super(name: name, model: model, association_name: association_name)
      end

      def foreign_key
        @model.reflect_on_association(association_name).foreign_key
      end

      def table_name
        @model.reflect_on_association(association_name).table_name
      end
    end
  end
end
