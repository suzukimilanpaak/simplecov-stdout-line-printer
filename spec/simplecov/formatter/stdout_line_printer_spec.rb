# frozen_string_literal: true

require 'spec_helper'
require 'simplecov'
require 'simplecov/result'
require 'simplecov/file_list'

RSpec.describe SimpleCov::Formatter::StdoutLinePrinter do
  describe '#format' do
    let(:result) { SimpleCov::Result.new(original_result) }
    let(:fully_covered) { 'spec/fixtures/sample.rb' }
    let(:partially_covered) { 'spec/fixtures/app/models/user.rb' }
    let(:uncovered) { 'spec/fixtures/app/controllers/sample_controller.rb' }

    context 'with single fully covered source code' do
      subject(:actual) { described_class.new.format(result) }

      let(:original_result) do
        {
          File.expand_path(fully_covered) => {
            'lines': [nil, 1, 1, 1, nil, nil, 1, 1, nil, nil]
          }
        }
      end

      it { expect(actual).to match(/\(100.0%\) covered /) }
      it "doesn't print fully covered source file" do
        expect(actual).not_to match(/#{fully_covered}/)
      end
    end

    context 'with single partially covered source code' do
      subject(:actual) { described_class.new.format(result) }

      let(:original_result) do
        {
          File.expand_path(partially_covered) => {
            'lines': [nil, 1, 1, 1, nil, nil, 1, 0, nil, nil]
          }
        }
      end

      it { expect(actual).to match(/\(80.0%\) covered /) }
      it "prints partially covered source file" do
        expect(actual).to match(/#{partially_covered}/)
      end
      it "prints the line of uncovered code" do
        expect(actual).to match('8:     @foo')
      end
    end

    context 'with single uncovered source code' do
      subject(:actual) { described_class.new.format(result) }

      let(:original_result) do
        {
          File.expand_path(uncovered) => {
            'lines': [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
          }
        }
      end

      it { expect(actual).to match(/\(0.0%\) covered /) }
      it "prints uncovered source file" do
        expect(actual).to match(/#{uncovered}/)
      end
      it "prints the line of uncovered code" do
        expect(actual).to match(/1: # FooController/)
        expect(actual).to match(/2: class FooController/)
        expect(actual).to match(/3:   def initialize/)
        expect(actual).to match(/4:     @foo = \"baz\"/)
        expect(actual).to match(/5:   end/)
        expect(actual).to match(/6:/)
        expect(actual).to match(/7:   def bar/)
        expect(actual).to match(/8:     @bar ||= 'bar'/)
        expect(actual).to match(/9:   end/)
        expect(actual).to match(/10: end/)
      end
    end

    context 'with multiple files of source code' do
      subject(:actual) { described_class.new.format(result) }

      let(:original_result) do
        {
          File.expand_path(fully_covered) => {
            'lines': [nil, 1, 1, 1, nil, nil, 1, 1, nil, nil]
          },
          File.expand_path(partially_covered) => {
            'lines': [nil, 1, 1, 1, nil, nil, 1, 0, nil, nil]
          },
          File.expand_path(uncovered) => {
            'lines': [nil, 0, 0, 0, nil, nil, 0, 0, nil, nil]
          }
        }
      end

      it { expect(actual).to match(/\(60.0%\) covered /) }
      it "doesn't print fully covered source file" do
        expect(actual).not_to match(/#{fully_covered}/)
      end
      it "prints partially covered source file" do
        expect(actual).to match(/#{partially_covered}/)
      end
      it "uncovered source file" do
        expect(actual).to match(/#{uncovered}/)
      end
    end
  end
end
