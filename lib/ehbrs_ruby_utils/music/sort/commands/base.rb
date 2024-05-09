# frozen_string_literal: true

require 'ehbrs_ruby_utils/core_ext'

module EhbrsRubyUtils
  module Music
    module Sort
      module Commands
        class Base
          enable_speaker
          enable_simple_cache
          common_constructor :root, :confirm do
            self.root = root.to_pathname
            run
          end

          private

          def config_file
            scanner.config_file
          end

          def scanner_uncached
            ::Scanner.new(root)
          end
        end
      end
    end
  end
end
