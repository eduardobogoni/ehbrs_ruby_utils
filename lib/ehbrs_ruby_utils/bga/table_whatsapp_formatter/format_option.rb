# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'

module EhbrsRubyUtils
  module Bga
    class TableWhatsappFormatter
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
