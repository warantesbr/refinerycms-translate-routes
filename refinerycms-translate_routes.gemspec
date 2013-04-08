# Encoding: UTF-8

Gem::Specification.new do |s|
  s.platform          = Gem::Platform::RUBY
  s.name              = 'refinerycms-translate_routes'
  s.version           = '1.0'
  s.description       = 'Ruby on Rails Translate Routes extension for Refinery CMS'
  s.date              = '2012-10-26'
  s.summary           = 'Translate Routes extension for Refinery CMS'
  s.require_paths     = %w(lib)
  s.files             = Dir["{app,config,db,lib}/**/*"] + ["readme.md"]

  # Runtime dependencies
  s.add_dependency             'refinerycms-core',    '~> 2.0.4'
  s.add_dependency             'rails-translate-routes',    '~> 0.1.3'

  # Development dependencies (usually used for testing)
  s.add_development_dependency 'refinerycms-testing', '~> 2.0.4'
end
