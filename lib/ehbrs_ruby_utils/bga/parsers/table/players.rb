# frozen_string_literal: true

require 'aranha/parsers/html/item'
require 'aranha/parsers/html/item_list'
require 'eac_ruby_utils/core_ext'

module EhbrsRubyUtils
  module Bga
    module Parsers
      class Table < ::Aranha::Parsers::Html::Item
        class Players < ::Aranha::Parsers::Html::ItemList
          ITEMS_XPATH = '//div[starts-with(@id, "score_entry_")]'

          field :table_rank, :integer, './div[@class = "rank"]'
          field :id, :integer, './div[@class = "name"]/a/@href'
          field :name, :string, './div[@class = "name"]/a/text()'
          field :score, :integer, './div[@class = "score"]'
          field :win_points, :string, './/*[starts-with(@id, "winpoints_value_")]/text()'
          field :game_rank, :integer, './/*[@class = "gamerank_value"]/text()'

          def items_xpath
            ITEMS_XPATH
          end
        end
      end
    end
  end
end