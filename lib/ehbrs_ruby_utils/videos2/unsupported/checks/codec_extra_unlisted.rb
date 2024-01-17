# frozen_string_literal: true

module EhbrsRubyUtils
  module Videos2
    module Unsupported
      module Checks
        class CodecExtraUnlisted
          TYPE = :stream

          common_constructor :codec, :listed_extras

          def check(track)
            return nil unless track.codec_name == codec
            return nil if listed_extras.any? do |extra|
              track.extra.downcase.include?(extra.downcase)
            end

            "Not listed extra for codec \"#{codec}\" (Track: #{track}" \
              ", listed extra: #{listed_extras})"
          end

          def fix
            nil
          end
        end
      end
    end
  end
end
