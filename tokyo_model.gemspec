# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{tokyo_model}
  s.version = "0.0.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Adrian Mugnolo", "Norman Clarke"]
  s.date = %q{2009-04-17}
  s.description = %q{}
  s.email = ["adrian@mugnolo.com", "norman@randomba.org"]
  s.extra_rdoc_files = ["History.txt", "Manifest.txt", "README.rdoc"]
  s.files = ["History.txt", "Manifest.txt", "README.rdoc", "Rakefile", "lib/tokyo_model.rb", "lib/tokyo_model/adapters/abstract_adapter.rb", "lib/tokyo_model/adapters/file.rb", "lib/tokyo_model/adapters/tyrant.rb", "lib/tokyo_model/persistable.rb", "script/console", "script/destroy", "script/generate", "test/contest.rb", "test/fixtures/post.rb", "test/test_basic_model.rb", "test/test_file_adapter.rb", "test/test_helper.rb"]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/rubysouth/tokyo_model}
  s.rdoc_options = ["--main", "README.rdoc"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{tokyo-model}
  s.rubygems_version = %q{1.3.2}
  s.summary = %q{}
  s.test_files = ["test/test_basic_model.rb", "test/test_file_adapter.rb", "test/test_helper.rb"]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<newgem>, [">= 1.3.0"])
      s.add_development_dependency(%q<hoe>, [">= 1.8.0"])
    else
      s.add_dependency(%q<newgem>, [">= 1.3.0"])
      s.add_dependency(%q<hoe>, [">= 1.8.0"])
    end
  else
    s.add_dependency(%q<newgem>, [">= 1.3.0"])
    s.add_dependency(%q<hoe>, [">= 1.8.0"])
  end
end
