# frozen_string_literal: true

require 'aranha/selenium/session'
require 'eac_ruby_utils/core_ext'

module EhbrsRubyUtils
  module Bga
    module Urls
      common_concern

      module InstanceMethods
        ROOT_URL = 'https://boardgamearena.com'

        # @param suffix [String]
        # @return [Addressable::URI]
        def build_url(suffix)
          root_url + suffix
        end

        # @return [Addressable::URI]
        def root_url
          ROOT_URL.to_uri
        end

        # @return [Addressable::URI]
        def table_url(table_id)
          build_url("/table?table=#{table_id}")
        end
      end

      extend InstanceMethods
    end
  end
end
