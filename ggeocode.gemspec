## ggeocode.gemspec
#

Gem::Specification::new do |spec|
  spec.name = "ggeocode"
  spec.version = "0.0.2"
  spec.platform = Gem::Platform::RUBY
  spec.summary = "ggeocode"
  spec.description = "simple wrapper on google's new geocoding api"

  spec.files = ["ggeocode.gemspec", "lib", "lib/ggeocode.rb", "Rakefile", "README"]
  spec.executables = []
  
  spec.require_path = "lib"

  spec.has_rdoc = true
  spec.test_files = nil

# spec.add_dependency 'lib', '>= version'
  spec.add_dependency 'map', '>= 2.3.0'
  spec.add_dependency 'yajl-ruby', '>= 0.7.9'

  spec.extensions.push(*[])

  spec.rubyforge_project = "codeforpeople"
  spec.author = "Ara T. Howard"
  spec.email = "ara.t.howard@gmail.com"
  spec.homepage = "http://github.com/ahoward/ggeocode"
end
