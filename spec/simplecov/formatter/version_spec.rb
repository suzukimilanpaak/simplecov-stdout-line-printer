# frozen_string_literal: true

require 'spec_helper'

RSpec.describe SimpleCov::Formatter::StdoutLinePrinter do
  it do
    expect(
      described_class::VERSION
    ).to match(
      /^([0-9]+)\.([0-9]+)\.([0-9]+)(?:-([0-9A-Za-z-]+(?:\.[0-9A-Za-z-]+)*))?(?:\+[0-9A-Za-z-]+)?$/
    )
  end

end
