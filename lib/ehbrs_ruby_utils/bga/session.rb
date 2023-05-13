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

      # @return [String]
      def message_info
        wait_for_click(id: MESSAGE_ID).text
      end

      # @return [EhbrsRubyUtils::Bga::Session::Player]
      def player(id)
        ::EhbrsRubyUtils::Bga::Session::Player.new(self, id)
      end

      require_sub __FILE__, include_modules: true, require_mode: :kernel
    end
  end
end
