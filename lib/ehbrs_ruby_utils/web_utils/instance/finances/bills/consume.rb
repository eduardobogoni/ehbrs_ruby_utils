# frozen_string_literal: true

require 'avm/instances/base'
require 'eac_ruby_utils/core_ext'

module EhbrsRubyUtils
  module WebUtils
    class Instance < ::Avm::Instances::Base
      class Finances
        class Bills
          class Consume
            require_sub __FILE__
            common_constructor(:bills)
            delegate :instance, :pending_directory, :registered_directory, to: :bills

            def perform
              bills.pending_directory.glob('**/*').each do |path|
                next unless path.file?

                ::EhbrsRubyUtils::WebUtils::Instance::Finances::Bills::Consume::File.new(self, path)
              end
            end
          end
        end
      end
    end
  end
end
