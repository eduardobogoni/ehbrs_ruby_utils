# frozen_string_literal: true

require 'ehbrs_ruby_utils/videos/stream'

RSpec.describe EhbrsRubyUtils::Videos::Stream do
  include_examples 'source_target_fixtures', __FILE__

  def source_data(source_file)
    instance = described_class.new(YAML.load_file(source_file))
    %w[codec_name codec_long_name codec_tag codec_tag_string codec_type index language
       language_with_title title]
      .map { |k| [k.to_sym, instance.send(k)] }.sort.to_h
  end
end
