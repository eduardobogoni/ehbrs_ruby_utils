# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'

module EhbrsRubyUtils
  module Bga
    class Table
      module WhatsappFormatters
        class Ending
          class FormatOption
            enable_method_class
            common_constructor :table_formatter, :option

            def result
              "*#{option.label}:* #{option.value}"
            end
          end
        end
      end
    end
  end
end
