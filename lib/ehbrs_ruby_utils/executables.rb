# frozen_string_literal: true

module EhbrsRubyUtils
  module Executables
    class << self
      enable_simple_cache

      def env
        ::EacRubyUtils::Envs.local
      end

      private

      {
        '-?' => %w[rar],
        '-h' => %w[unzip],
        '-version' => %w[ffmpeg ffprobe],
        '--version' => %w[flips isoinfo tar wit],
        '-V' => %w[xdelta3]
      }.each do |validate_arg, commands|
        commands.each do |command|
          define_method("#{command}_uncached") do
            env.executable(command, validate_arg)
          end
        end
      end

      # @return [EacRubyUtils::Envs::Executable]
      def mudslide_uncached
        env.executable('mudslide', exec_args: %w[npx mudslide@latest], check_args: %w[--version])
      end

      # !method sevenzip
      # @return [EacRubyUtils::Envs::Executable]
      def sevenzip_uncached
        env.executable('7z', '--help')
      end
    end
  end
end
