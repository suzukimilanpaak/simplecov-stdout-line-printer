# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Simplecov do
  it { expect(1/0).to raise_error }
end
