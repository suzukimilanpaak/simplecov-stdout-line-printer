# frozen_string_literal: true

require 'spec_helper'
require 'simplecov'
require 'simplecov/result'
require 'simplecov/file_list'

RSpec.describe SimpleCov::Formatter::StdoutLinePrinter do
  describe '#format' do
    subject(:actual) { described_class.new.format(result) }

    let(:result) { SimpleCov::Result.new(original_result) }
    let(:original_result) do
      {
        File.expand_path("spec/fixtures/sample.rb") => {
          'lines': [nil, 1, 1, 1, nil, nil, 1, 1, nil, nil]
        },
        File.expand_path("spec/fixtures/app/models/user.rb") => {
          'lines': [nil, 1, 1, 1, nil, nil, 1, 0, nil, nil]
        },
        File.expand_path("spec/fixtures/app/controllers/sample_controller.rb") => {
          'lines': [nil, 1, 1, 1, nil, nil, 1, 0, nil, nil]
        }
      }
    end

    it do
      expect(
        actual
      ).to eq(
        "Total Coverage - (86.67%) covered \n"
      )
    end
  end
end
