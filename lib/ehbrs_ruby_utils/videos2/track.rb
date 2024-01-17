# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'
require 'ehbrs_ruby_utils/videos/stream'

module EhbrsRubyUtils
  module Videos2
    class Track < ::SimpleDelegator
      def extra
        ffprobe_data.fetch(:codec_tag_string).to_s
      end

      def to_s
        "[#{codec_type}(#{index}): #{codec_name}/#{language || '-'}#{extra.if_present('') do |v|
                                                                       " | #{v}"
                                                                     end}]"
      end
    end
  end
end
