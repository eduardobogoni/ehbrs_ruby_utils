# frozen_string_literal: true

require 'aranha/parsers/html/item'
require 'eac_ruby_utils/core_ext'

module EhbrsRubyUtils
  module Bga
    module Parsers
      class Table < ::Aranha::Parsers::Html::Item
        ITEM_XPATH = '/'

        field :game_name, :string, './/*[@id = "table_name"]/text()'
        field :creation_time, :string, './/*[@id = "creationtime"]/text()'
        field :estimated_duration, :string, './/*[@id = "estimated_duration"]/text()'
        field :options, :node, './/*[@id = "gameoptions"]'
        field :players, :node, './/*[@id = "game_result"]'

        def item_xpath
          ITEM_XPATH
        end

        def data
          r = super
          %i[options players].each do |key|
            r[key] = self.class.const_get(key.to_s.camelize).from_node(r.fetch(key)).data
          end
          r[:creation_time] = process_creation_time(r[:creation_time])
          r
        end

        private

        def process_creation_time(creation_time)
          creation_time.gsub('Criado:', '').strip
        end

        require_sub __FILE__
      end
    end
  end
end
