# frozen_string_literal: true

require_relative "lib/rubypostal/version"

Gem::Specification.new do |spec|
  spec.name = "rubypostal"
  spec.version = Rubypostal::VERSION
  spec.authors = ["Nijeesh Joshy"]
  spec.email = ["nijeesh.k@rently.com"]

  spec.summary = "rubypostal is a Ruby gem that provides seamless integration with the Libpostal C library,"

  spec.description = "rubypostal is designed to bridge the gap between Ruby and the powerful Libpostal C library." \
                      "offering a clean and intuitive API for address processing tasks."

  spec.homepage = "https://github.com/nijeesh4all/rubypostal"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.1"

  spec.metadata["allowed_push_host"] = "TODO: Set to your gem server 'https://example.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/nijeesh4all/rubypostal"
  spec.metadata["changelog_uri"] = "https://github.com/nijeesh4all/rubypostal"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .github appveyor Gemfile])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "ffi"
end
