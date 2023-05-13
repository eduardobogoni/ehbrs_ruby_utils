# frozen_string_literal: true

require 'ehbrs_ruby_utils/bga/parsers/game_stats'
require 'ehbrs_ruby_utils/bga/urls'
require 'eac_ruby_utils/core_ext'

module EhbrsRubyUtils
  module Bga
    class Session < ::SimpleDelegator
      class Player
        include ::EhbrsRubyUtils::Bga::Urls
        GAME_HISTORY_XPATH = '//h3[text() = "Games history"]'
        common_constructor :session, :player_id

        def tables
          session.navigate.to game_stats_url
          session.wait_for_element(xpath: GAME_HISTORY_XPATH)
          ::EhbrsRubyUtils::Bga::Parsers::GameStats.from_content(session.current_source).data
        end

        # @return [Addressable::URI]
        def game_stats_url
          session.url("/gamestats?player=#{player_id}")
        end
      end
    end
  end
end
