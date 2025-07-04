# frozen_string_literal: true

module EhbrsRubyUtils
  module Videos2
    module Unsupported
      class CheckResult
        enable_simple_cache
        common_constructor :source, :check

        def passed?
          message.blank?
        end

        private

        def message_uncached
          check.check(source)
        end
      end
    end
  end
end
