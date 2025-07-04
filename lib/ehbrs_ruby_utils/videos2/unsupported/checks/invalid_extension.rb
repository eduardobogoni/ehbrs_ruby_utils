# frozen_string_literal: true

module EhbrsRubyUtils
  module Videos2
    module Unsupported
      module Checks
        class InvalidExtension
          TYPE = :container

          common_constructor :extension

          def check(video)
            return nil unless ::File.extname(video.path) == extension

            "File has invalid extension: #{extension}"
          end

          def fix
            ::EhbrsRubyUtils::Videos2::Unsupported::Fixes::SupportedContainer.new
          end
        end
      end
    end
  end
end
