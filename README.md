# SpaceshipMissionSimulator

The goal of this gem is to calculate fuel to launch from one planet of the Solar System, and land to another planet of the Solar System, depending on the flight route.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'spaceship_mission_simulator'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install spaceship_mission_simulator

## Usage

```ruby
require 'spaceship_mission_simulator'

class SpaceshipCommandCenter
  include SpaceshipMissionSimulator

  # ...
end

scc = SpaceshipCommandCenter.new

raw_path = [[:launch, 9.807], [:land, 1.62], [:launch, 1.62], [:land, 9.807]]
scc.simulate_spaceship_mission! 28_801, raw_path

# => #<Interactor::Context result=#<struct SpaceshipMissionSimulator::SimulationResult initial_weight=28801, total_fuel_weight=51898, path=#<struct SpaceshipMissionSimulator::Path raw_data=[[:launch, 9.807], [:land, 1.62], [:launch, 1.62], [:land, 9.807]], events=[#<struct SpaceshipMissionSimulator::Event state=:launch, planet=#<struct SpaceshipMissionSimulator::Planet gravity=9.807, key=:earth, name="Earth">, reserved_fuel_weight=18910, fuel_weight=32988>, #<struct SpaceshipMissionSimulator::Event state=:land, planet=#<struct SpaceshipMissionSimulator::Planet gravity=1.62, key=:moon, name="Moon">, reserved_fuel_weight=16448, fuel_weight=2462>, #<struct SpaceshipMissionSimulator::Event state=:launch, planet=#<struct SpaceshipMissionSimulator::Planet gravity=1.62, key=:moon, name="Moon">, reserved_fuel_weight=13447, fuel_weight=3001>, #<struct SpaceshipMissionSimulator::Event state=:land, planet=#<struct SpaceshipMissionSimulator::Planet gravity=9.807, key=:earth, name="Earth">, reserved_fuel_weight=0, fuel_weight=13447>]>>>

scc.print_spaceship_mission_result 28_801, raw_path

# =>

[
    [0] "path: launch Earth, land Moon, launch Moon, land Earth",
    [1] "weight of equipment: 28801 kg",
    [2] "weight of fuel: 51898 kg",
    [3] "arguments: 28801, [[:launch, 9.807], [:land, 1.62], [:launch, 1.62], [:land, 9.807]]"
]
```

Or you can use rake task to print result:

    $ rake spaceship_mission_simulator:print_result[28_801,'launch: 9.807; land: 1.62; launch: 1.62; land: 9.807']

```
# =>

[
    [0] "path: launch Earth, land Moon, launch Moon, land Earth",
    [1] "weight of equipment: 28801 kg",
    [2] "weight of fuel: 51898 kg",
    [3] "arguments: 28801, [[:launch, 9.807], [:land, 1.62], [:launch, 1.62], [:land, 9.807]]"
]
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/acidwizard/spaceship_mission_simulator.


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
