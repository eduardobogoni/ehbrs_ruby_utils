# frozen_string_literal: true

module EhbrsRubyUtils
  module Vg
    module Wii
      module Wit
        module Parsers
          class Dump
            enable_simple_cache
            common_constructor :output

            # WIA/WII (v1.00,LZMA2.7@100)  &  Wii
            # ISO/WII  &  Wii
            # WBFS/WII  &  Wii
            # ISO/GC  &  GameCube
            FILE_DISC_TYPE_PATTERN = %r{\A(\S+)/(\S+)\s+(?:\(([^\)]+)\)\s+)?&\s+(\S+)\z}.freeze

            private

            def properties_uncached
              r = {}
              output.each_line do |line|
                dump_output_line_to_hash(line).if_present { |v| r.merge!(v) }
              end
              r
            end

            def dump_output_line_to_hash(line)
              m = /\A\s*([^:]+):\s+(.+)\z/.match(line.strip)
              return nil unless m

              parse_attribute(m[1].strip, m[2].strip)
            end

            def line_method_parser(label)
              "parse_#{label}".parameterize.underscore
            end

            def parse_attribute(label, value)
              method = line_method_parser(label)
              return { label => value } unless respond_to?(method, true)

              send(method, value).transform_keys { |k| "#{label}/#{k}" }
            end

            def parse_file_disc_type(value)
              r = FILE_DISC_TYPE_PATTERN.match(value).if_present do |m|
                { type: m[1], platform_acronym: m[2], type_extra: m[3],
                  platform_name: m[4] }
              end
              r.if_blank { raise "\"#{FILE_DISC_TYPE_PATTERN}\" does not match \"#{value}\"" }
            end

            def parse_disc_part_ids(value)
              value.split(',').to_h do |v|
                r = v.strip.split('=')
                [r[0].strip, r[1].strip]
              end
            end
          end
        end
      end
    end
  end
end
