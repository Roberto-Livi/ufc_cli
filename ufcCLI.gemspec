require_relative 'lib/ufcCLI/version'

Gem::Specification.new do |spec|
  spec.name          = "ufcCLI"
  spec.version       = UfcCLI::VERSION
  spec.authors       = ["Roberto Livi"]
  spec.email         = ["robertomlivi@outlook.com"]

  spec.summary       = "Simple Ruby CLI app"
  spec.description   = "Displays the UFC Rankings, Fighter's info, and has a game where you can guess a random fighters nickname"
  spec.homepage      = "https://github.com/Roberto-Livi/ufc_cli"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/Roberto-Livi/ufc_cli"
  spec.metadata["changelog_uri"] = "https://github.com/Roberto-Livi/ufc_cli"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "pry"
  spec.add_development_dependency "httparty"
  spec.add_development_dependency "nokogiri"
end
