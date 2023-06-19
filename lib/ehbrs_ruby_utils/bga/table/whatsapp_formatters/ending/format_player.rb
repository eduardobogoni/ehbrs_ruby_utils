# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'

module EhbrsRubyUtils
  module Bga
    class Table
      module WhatsappFormatters
        class Ending
          class FormatPlayer
            enable_method_class
            common_constructor :table_formatter, :player

            FIELD_SEPARATOR = ' - '

            def result
              %w[table_rank name score].map { |v| send(v) }.join(FIELD_SEPARATOR)
            end

            def table_rank
              "*#{player.rank}º*"
            end

            delegate :name, to: :player

            def score
              "⭐ #{player.score}"
            end
          end
        end
      end
    end
  end
end
