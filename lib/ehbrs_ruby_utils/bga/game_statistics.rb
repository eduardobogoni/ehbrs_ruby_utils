# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'

module EhbrsRubyUtils
  module Bga
    class GameStatistics
      common_constructor :game, :game_tables, :players, :until_table, default: [nil]

      require_sub __FILE__
    end
  end
end
