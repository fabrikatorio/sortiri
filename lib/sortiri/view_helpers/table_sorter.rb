# frozen_string_literal: true

module Sortiri
  module ViewHelpers
    module TableSorter
      def sort_link(activerecord_relation_object, column, title, css_class = nil)
        sort_string = params[:sort].presence || activerecord_relation_object.klass.default_sort
        sorter = Sortiri::Utils.new(sort_string: sort_string, column_name: column)

        link_to(request.query_parameters.merge({ sort: "#{sorter.direction}#{column}" }), class: css_class) do
          concat title
          concat content_tag(:i, '', class: sorter.icon_class)
        end
      end
    end
  end
end
