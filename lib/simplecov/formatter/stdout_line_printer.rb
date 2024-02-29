# frozen_string_literal: true

require_relative '../at_exit'

module SimpleCov
  module Formatter

    # a simplecov formatter to print coverage result
    #
    class StdoutLinePrinter
      def format(result)
        output = +""
        output << "Total Coverage - (#{result.covered_percent.round(2)}%) covered \n"
        if result.groups.empty?
          output << format_files(result.files)
        else
          output << format_groups(result.groups)
        end
        output
      end

      private

      def min_cov
        return @min_cov if defined?(@min_cov)

        whole_cov = SimpleCov.minimum_coverage[:line] || 0
        file_cov = SimpleCov.minimum_coverage_by_file[:line] || 0
        min_cov = [whole_cov, file_cov].max
        @min_cov = min_cov.zero? ? 100 : min_cov
      end

      def format_groups(groups)
        output = +""
        groups.each do |name, files|
          output << "Group: #{name}\n"
          output << "=" * 40
          output << "\n"
          output << (format_files(files).presence || "None - sufficient coverage")
          output << "\n"
        end
        output
      end

      def format_files(files)
        output = +""
        files.each do |file|
          if file.covered_percent < min_cov
            output << "#{file.filename} (coverage: #{file.covered_percent.round(2)}%)\n"
            file.missed_lines.each do |line|
              output << "#{"% 3d" % line.line_number}: #{line.src}"
            end
            output << "\n"
          end
        end
        output
      end
    end
  end
end

