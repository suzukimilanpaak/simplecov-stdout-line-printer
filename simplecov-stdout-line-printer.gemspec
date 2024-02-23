require_relative 'lib/simplecov/stdout/line/printer/version'

Gem::Specification.new do |spec|
  spec.name          = 'simplecov-stdout-line-printer'
  spec.version       = Simplecov::Stdout::Line::Printer::VERSION
  spec.authors       = ['Tatsuya Suzuki']
  spec.email         = ['sin.wave808@gmail.com']

  spec.summary       = %q{`simplecov-stdout-line-printer` is one of the formatters for Simplecov, which prints each uncovered line to STDOUT.}
  spec.description   = %q{`simplecov-stdout-line-printer` is one of the formatters for Simplecov, which prints each uncovered line to STDOUT. It is intended to be used in an environment where you can't store the test results to a file but can check them in the log of RSpec.}
  spec.homepage      = 'https://github.com/suzukimilanpaak/simplecov-stdout-line-printer'
  spec.license       = 'MIT'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.3.0')

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = spec.homepage
  spec.metadata['changelog_uri'] = 'https://github.com/suzukimilanpaak/simplecov-stdout-line-printer/releases'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']
end
