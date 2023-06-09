# frozen_string_literal: true

require 'aranha/selenium/session'
require 'eac_ruby_utils/core_ext'
require 'ehbrs_ruby_utils/bga/urls'

module EhbrsRubyUtils
  module Bga
    class Session < ::SimpleDelegator
      include ::EhbrsRubyUtils::Bga::Urls
      MESSAGE_ID = 'head_infomsg_1'

      common_constructor :username, :password, super_args: -> { [::Aranha::Selenium::Session.new] }

      # @return [EhbrsRubyUtils::Bga::Session::Player]
      def player(id)
        ::EhbrsRubyUtils::Bga::Session::Player.new(self, id)
      end

      # @return [String, nil]
      def message_info
        find_or_not_element(id: MESSAGE_ID).if_present { |v| v.text.strip }
      end

      require_sub __FILE__, include_modules: true, require_mode: :kernel
    end
  end
end
