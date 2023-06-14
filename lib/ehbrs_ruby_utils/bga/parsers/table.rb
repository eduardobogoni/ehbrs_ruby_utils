# frozen_string_literal: true

require 'aranha/parsers/html/item'
require 'eac_ruby_utils/core_ext'

module EhbrsRubyUtils
  module Bga
    module Parsers
      class Table < ::Aranha::Parsers::Html::Item
        GAME_IMAGE_URL_PARSER = %r{/gamemedia/([^/]+)/box/}.to_parser { |m| m[1] }
        ITEM_XPATH = '/'

        field :game_code, :string, '//meta[@property="og:image"]/@content'
        field :game_name, :string, './/*[@id = "table_name"]/text()'
        field :creation_time, :string, './/*[@id = "creationtime"]/text()'
        field :estimated_duration, :string, './/*[@id = "estimated_duration"]/text()'
        field :options, :node, './/*[@id = "gameoptions"]'
        field :players, :node, './/*[@id = "game_result"]'
        field :game_conceded, :node, './/*[@id = "game_conceded" and @style="display: block;"]'

        def item_xpath
          ITEM_XPATH
        end

        def data
          r = super
          %i[creation_time game_code game_conceded options players].each do |key|
            r[key] = send("process_#{key}", r.fetch(key))
          end
          r
        end

        private

        def process_creation_time(creation_time)
          creation_time.gsub('Criado:', '').strip
        end

        # @param node [String]
        # @return [String]
        def process_game_code(image_url)
          GAME_IMAGE_URL_PARSER.parse!(image_url)
        end

        # @param node [Nokogiri::XML::Element]
        # @return [Boolean]
        def process_game_conceded(node)
          node.present?
        end

        # @param node [Nokogiri::XML::Element]
        # @return [Hash]
        def process_options(node)
          ::EhbrsRubyUtils::Bga::Parsers::Table::Options.from_node(node).data
        end

        # @param node [Nokogiri::XML::Element]
        # @return [Hash]
        def process_players(node)
          ::EhbrsRubyUtils::Bga::Parsers::Table::Players.from_node(node).data
        end

        require_sub __FILE__
      end
    end
  end
end
