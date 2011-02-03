## ggeocode.gemspec
#

Gem::Specification::new do |spec|
  spec.name = "ggeocode"
  spec.version = "0.0.1"
  spec.platform = Gem::Platform::RUBY
  spec.summary = "ggeocode"
  spec.description = "description: ggeocode kicks the ass"

  spec.files = ["lib", "lib/ggeocode.rb", "Rakefile", "README"]
  spec.executables = []
  
  spec.require_path = "lib"

  spec.has_rdoc = true
  spec.test_files = nil

# spec.add_dependency 'lib', '>= version'

  spec.extensions.push(*[])

  spec.rubyforge_project = "codeforpeople"
  spec.author = "Ara T. Howard"
  spec.email = "ara.t.howard@gmail.com"
  spec.homepage = "http://github.com/ahoward/ggeocode"
end
