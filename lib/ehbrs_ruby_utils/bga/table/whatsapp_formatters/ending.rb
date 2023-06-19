# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'

module EhbrsRubyUtils
  module Bga
    class Table
      module WhatsappFormatters
        class Ending
          enable_simple_cache
          common_constructor :table

          ROOT_ITENS = {
            'Jogo' => :game_name,
            'Criada em' => :creation_time,
            'Duração' => :estimated_duration,
            'Endereço' => :url
          }.freeze
          SECTION_SEPARATOR = "\n\n"
          TITLE_ICON = 0x1F3C6.chr(::Encoding::UTF_8)

          # @return [Pathname]
          def image_local_path
            table.game.box_large_image.local_path
          end

          def to_s
            [root_items_to_s, players_to_s, options_to_s].map(&:strip).join(SECTION_SEPARATOR)
          end

          def root_items_to_s
            title_to_s('Mesa terminada') + ROOT_ITENS.map { |k, v| "*#{k}*: #{table.send(v)}" }
                                             .join("\n")
          end

          # @return [String]
          def game_conceded_to_s
            table.game_conceded? ? "*Derrota admitida*\n\n" : ''
          end

          def players_to_s
            title_to_s('Resultado') + game_conceded_to_s + players.join("\n")
          end

          def options_to_s
            title_to_s('Opções') + options.join("\n")
          end

          def title_to_s(title)
            '*' + [TITLE_ICON, title, TITLE_ICON].join(' ') + "*\n\n"
          end

          def players
            table.players.map { |player| format_player(player) }
          end

          def options
            table.options.map { |player| format_option(player) }
          end

          require_sub __FILE__, require_mode: :kernel
        end
      end
    end
  end
end
