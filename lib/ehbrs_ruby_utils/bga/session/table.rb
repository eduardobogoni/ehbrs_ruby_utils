# frozen_string_literal: true

require 'ehbrs_ruby_utils/bga/parsers/table'
require 'ehbrs_ruby_utils/bga/table'
require 'ehbrs_ruby_utils/bga/urls'
require 'eac_ruby_utils/core_ext'

module EhbrsRubyUtils
  module Bga
    class Session < ::SimpleDelegator
      class Table
        include ::EhbrsRubyUtils::Bga::Urls
        enable_method_class
        enable_simple_cache
        common_constructor :session, :table_id

        RESULTS_XPATH = '//*[@id = "game_result"]'

        def result
          ::EhbrsRubyUtils::Bga::Table.new(
            fetch_data
          )
        end

        # @return [Addressable::URI]
        def url
          table_url(table_id)
        end

        private

        def fetch_data
          session.navigate.to url
          session.wait_for_element(xpath: RESULTS_XPATH)
          { id: table_id }.merge(
            ::EhbrsRubyUtils::Bga::Parsers::Table.from_content(session.current_source).data
          )
        end
      end
    end
  end
end
