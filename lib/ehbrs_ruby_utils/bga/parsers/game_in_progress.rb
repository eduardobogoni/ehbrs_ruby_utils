# frozen_string_literal: true

require 'aranha/parsers/html/item_list'
require 'eac_ruby_utils/core_ext'

module EhbrsRubyUtils
  module Bga
    module Parsers
      class GameInProgress < ::Aranha::Parsers::Html::ItemList
        ITEMS_XPATH = '//*[@id = "gametables_inprogress_all"]' \
          '//*[starts-with(@id, "gametableblock_")]'

        field :id, :integer, './@id'

        def items_xpath
          ITEMS_XPATH
        end
      end
    end
  end
end
