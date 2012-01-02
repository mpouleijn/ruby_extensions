# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "ruby_extensions/version"

Gem::Specification.new do |s|
  s.name = "ruby_extensions"
  s.version = RubyExtensions::VERSION
  s.authors = ["Michel Pouleijn"]
  s.email = ["michel@cttinnovations.com"]
  s.homepage = "https://github.com/mpouleijn/ruby_extensions"
  s.summary = %q{TODO: Write a gem summary}
  s.description = %q{TODO: Write a gem description}

  s.rubyforge_project = "ruby_extensions"

  s.files = `git ls-files`.split("\n")
  s.test_files = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables = `git ls-files -- bin/*`.split("\n").map { |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  s.add_development_dependency "rspec"
  s.add_development_dependency "mocha"
  s.add_development_dependency "guard"
  s.add_development_dependency "rb-inotify"
  s.add_development_dependency "rb-fsevent"
  s.add_development_dependency "rb-fchange"
  s.add_development_dependency "guard-rspec"
  s.add_development_dependency "guard-bundler"
  s.add_runtime_dependency "rake", "0.9.2.2"
end
