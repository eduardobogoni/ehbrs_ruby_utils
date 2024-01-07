# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'
require 'ehbrs_ruby_utils/bga/whatsapp_formatter'

module EhbrsRubyUtils
  module Bga
    class GameStatistics
      class WhatsappFormatter
        include ::EhbrsRubyUtils::Bga::WhatsappFormatter

        ROOT_TITLE = 'Estatísticas'
        TITLE_ICON = 0x1F4CA.chr(::Encoding::UTF_8)

        enable_simple_cache
        common_constructor :game_statistics
        delegate :game, :game_tables, :players, :until_table, to: :game_statistics

        # @return [Integer]
        def friendly_tables_count
          game_tables.count - normal_tables.count
        end

        # @return [Hash]
        def root_content
          r = { 'Jogo' => game.name, 'Mesas normais' => normal_tables.count,
                'Mesas amigáveis' => friendly_tables_count }
          until_table.if_present { |v| r['Após mesa'] = v.url }
          r
        end

        # @return [Hash<String, String>] "title" => "content"
        def sections
          r = { ROOT_TITLE => root_content }
          players.each do |player|
            r[player_title(player)] = player_content(player)
          end
          r
        end

        # @return [String]
        def title_icon
          TITLE_ICON
        end

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

        # @return [Array<Integer>]
        def ranks_uncached
          r = ::Set.new
          normal_tables.each do |table|
            table.players.each do |player|
              r.add(player.rank)
            end
          end
          r.sort
        end

        require_sub __FILE__, require_mode: :kernel
      end
    end
  end
end
