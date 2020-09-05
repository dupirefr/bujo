Gem::Specification.new do |spec|
  spec.name = %q{bujo}
  spec.version = "0.1.0"
  spec.date = %q{2020-08-23}
  spec.summary = %q{bujo is a support CLI to maintain Bullet Journal using AsciiDoctor}
  spec.authors = ["dupire.francois+pro@gmail.com"]
  spec.require_paths = ["lib"]
  spec.files = %w[lib/bujo.rb lib/options lib/plugins lib/shortcuts lib/utils]
  spec.executables << 'bujo'
end