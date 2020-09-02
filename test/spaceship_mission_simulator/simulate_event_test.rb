require_relative '../test_helper'

describe SpaceshipMissionSimulator::SimulateEvent do
  def result(raw_data, initial_weight, reserved_fuel_weight = nil)
    interactor_klass = SpaceshipMissionSimulator::SimulateEvent
    interactor_klass.call! raw_data: raw_data,
                           initial_weight: initial_weight,
                           reserved_fuel_weight: reserved_fuel_weight
  end

  def result_fuel_weight(*args)
    result(*args).event.fuel_weight
  end

  it 'calcs fuel for land by proper formula' do
    expect(result_fuel_weight([:land, 9.807], 28_801)).must_equal 13_447
  end

  it 'calcs fuel for launch by proper formula' do
    expect(result_fuel_weight([:launch, 9.807], 28_801)).must_equal 19_772
  end

  it 'calcs including reserved_fuel_weight' do
    expect(result_fuel_weight([:land, 9.807], 18_801, 10_000)).must_equal 13_447
  end

  it 'sets to 0 by default if reserved_fuel_weight not passed' do
    expect(result([:land, 9.807], 28_801).reserved_fuel_weight).must_equal 0
  end

  it 'fails if initial_weight not passed' do
    expect { result([:land, 9.807], nil) }.must_raise Interactor::Failure
  end

  it 'fails if event data not array' do
    raw_data = { land: 9.807, launch: 9.807 }
    expect { result(raw_data, 28_801) }.must_raise Interactor::Failure
  end

  it 'fails if wrong event data size' do
    raw_data = [:launch, 9.807, :land, 9.807]
    expect { result(raw_data, 28_801) }.must_raise Interactor::Failure
  end

  it 'fails if wrong event key' do
    expect { result([:start, 9.807], 28_801) }.must_raise Interactor::Failure
  end
end
