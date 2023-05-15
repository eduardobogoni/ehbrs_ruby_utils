# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'

module EhbrsRubyUtils
  module Bga
    class Session < ::SimpleDelegator
      module Login
        LOGIN_PATH = 'account'
        USERNAME_INPUT_ID = 'username_input'
        PASSWORD_INPUT_ID = 'password_input'
        SUBMIT_ID = 'login_button'
        LOGGED_MESSAGE_PATTERNS = [
          /Page not found/ # Page not found: join.js
        ].freeze
        UNLOGGED_MESSAGE_PATTERSN = [
          /Recover my password/ # Oops, we don't recognize your username or password. Don't panic.
          # (Recover my password)
        ].freeze

        # @return [Boolean]
        def login
          navigate_to_login_page
          input_username
          input_password
          submit_login
          logged_by_message?(waited_message_info)
        end

        def login_url
          build_url(LOGIN_PATH)
        end

        private

        def navigate_to_login_page
          navigate.to(login_url)
        end

        def input_username
          wait_for_element(id: USERNAME_INPUT_ID).send_keys(username)
        end

        def input_password
          wait_for_element(id: PASSWORD_INPUT_ID).send_keys(password)
        end

        def submit_login
          wait_for_click(id: SUBMIT_ID)
        end

        # @return [Boolean]
        def logged_by_message?(message_info)
          return true if LOGGED_MESSAGE_PATTERNS.any? { |p| p.match?(message_info) }
          return false if UNLOGGED_MESSAGE_PATTERNS.any? { |p| p.match?(message_info) }

          raise("Unmapped login message: \"#{message_info}\"")
        end
      end
    end
  end
end
