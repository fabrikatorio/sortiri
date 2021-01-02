# frozen_string_literal: true

module Sortiri
  class Configuration
    attr_accessor :up_arrow, :down_arrow

    def initialize
      @up_arrow = 'fas fa-angle-up'
      @down_arrow = 'fas fa-angle-down'
    end
  end
end
