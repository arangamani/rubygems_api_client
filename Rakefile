lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rubygems_api_client/version'
require 'rake'
require 'jeweler'

Jeweler::Tasks.new do |gemspec|
  gemspec.name             = 'rubygems_api_client'
  gemspec.version          = RubygemsApi::Client::VERSION
  gemspec.platform         = Gem::Platform::RUBY
  gemspec.date             = Time.now.utc.strftime("%Y-%m-%d")
  gemspec.require_paths    = ["lib"]
  gemspec.executables      = `git ls-files -- bin/*`.split("\n").map{|f| File.basename(f)}
  gemspec.files            = `git ls-files`.split("\n")
  gemspec.extra_rdoc_files = ['CHANGELOG.md', 'LICENSE', 'README.md']
  gemspec.authors          = [ 'Kannan Manickam' ]
  gemspec.email            = [ 'arangamani.kannan@gmail.com' ]
  gemspec.homepage         = 'https://github.com/arangamani/rubygems_api_client'
  gemspec.summary          = 'Rubygems JSON API Client'
  gemspec.description      = %{
This is a simple API client to communicate with Rubygems JSON API to obtain
details about Gems, Versions, Downloads, and Web Hooks}
  gemspec.test_files = `git ls-files -- {spec}/*`.split("\n")
  gemspec.rubygems_version = '1.8.17'
end
