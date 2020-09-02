require 'bundler/gem_tasks'
require 'rake/testtask'

desc 'Run tests'
Rake::TestTask.new do |t|
  t.libs << 'test'
  t.test_files = FileList['test/**/*_test.rb']
  t.warning = false
end

namespace :spaceship_mission_simulator do
  require 'spaceship_mission_simulator'

  include SpaceshipMissionSimulator

  desc 'Print spaceship mission simulation result'
  task :print_result, [:initial_weight, :raw_path] do |_t, args|
    correct_raw_path = args.raw_path.split('; ').map do |ev_data|
      ev_data.split(': ').tap do |ev_arr|
        ev_arr[0] = ev_arr[0].to_sym
        ev_arr[-1] = ev_arr[-1].to_f
      end
    end

    print_spaceship_mission_result args.initial_weight.to_i, correct_raw_path
  end
end
