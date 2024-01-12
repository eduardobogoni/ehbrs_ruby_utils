# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'

module EhbrsRubyUtils
  module Bga
    class GameStatistics
      enable_simple_cache
      common_constructor :game, :game_tables, :players, :until_table, default: [nil]

      private

      # @return [Enumerable<EhbrsRubyUtils::Bga::Table>]
      def normal_tables_uncached
        with_players_tables.reject(&:friendly?)
      end

      # @param table [EhbrsRubyUtils::Bga::Table]
      # @return [Boolean]
      def with_players_table?(table)
        table.players.count == players.count &&
          players.all? { |player| table.player_by_id(player.id).present? }
      end

      # @return [Enumerable<EhbrsRubyUtils::Bga::Table>]
      def with_players_tables_uncached
        game_tables.select { |table| with_players_table?(table) }
      end

      require_sub __FILE__
    end
  end
end
