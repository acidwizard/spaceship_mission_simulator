require_relative 'lib/spaceship_mission_simulator/version'

Gem::Specification.new do |spec|
  spec.name     = 'spaceship_mission_simulator'
  spec.version  = SpaceshipMissionSimulator::VERSION
  spec.authors  = ['acidwizard']

  spec.summary  = 'The goal of this gem is to calculate fuel to launch from one planet of the Solar System, and land to another planet of the Solar System, depending on the flight route.'
  spec.homepage = 'https://github.com/acidwizard/spaceship_mission_simulator'
  spec.license  = 'MIT'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/acidwizard/spaceship_mission_simulator'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir['lib/**/*.rb']

  spec.require_paths = ['lib']

  spec.required_ruby_version = Gem::Requirement.new '>= 2.3.0'

  spec.add_dependency 'awesome_print', '1.8.0'
  spec.add_dependency 'interactor', '3.1.2'

  spec.add_development_dependency 'minitest', '~> 5.0'
  spec.add_development_dependency 'rake', '~> 12.0'
  spec.add_development_dependency 'rubocop', '~> 0.8'
end
