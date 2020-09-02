require_relative '../test_helper'

describe SpaceshipMissionSimulator::Simulate do
  def result(initial_weight, raw_path)
    SpaceshipMissionSimulator::Simulate.call!(initial_weight: initial_weight,
                                              raw_path: raw_path).result
  end

  it 'calcs total fuel for spaceship mission' do
    raw_path = [[:launch, 9.807], [:land, 1.62],
                [:launch, 1.62], [:land, 9.807]]
    expect(result(28_801, raw_path).total_fuel_weight).must_equal 51_898
  end

  it 'fails if raw path not array' do
    raw_path = { land: 9.807, launch: 1.62 }
    expect { result(28_801, raw_path) }.must_raise Interactor::Failure
  end

  it 'fails if initial weight not passed' do
    raw_path = [[:launch, 9.807], [:land, 9.807]]
    expect { result(nil, raw_path) }.must_raise Interactor::Failure
  end

  it 'fails if wrong start mission event' do
    path1 = [[:launch, 1.62], [:land, 9.807]]
    path2 = [[:land, 9.807], [:launch, 9.807], [:land, 9.807]]

    [path1, path2].each do |raw_path|
      expect { result(28_801, raw_path) }.must_raise Interactor::Failure
    end
  end

  it 'fails if wrong finish mission event' do
    path1 = [[:launch, 9.807], [:land, 1.62], [:launch, 9.807]]
    path2 = [[:launch, 9.807], [:land, 1.62]]

    [path1, path2].each do |raw_path|
      expect { result(28_801, raw_path) }.must_raise Interactor::Failure
    end
  end

  it 'fails if path is inconsistent (pair of events has the same key)' do
    path1 = [[:launch, 9.807], [:land, 1.62], [:land, 9.807]]
    path2 = [[:launch, 9.807], [:land, 1.62], [:launch, 1.62], [:launch, 1.62], [:land, 9.807]]

    [path1, path2].each do |raw_path|
      expect { result(28_801, raw_path) }.must_raise Interactor::Failure
    end
  end
end
