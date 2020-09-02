require_relative '../test_helper'

describe SpaceshipMissionSimulator::IdentifyPlanet do
  def result(gravity)
    SpaceshipMissionSimulator::IdentifyPlanet.call! gravity: gravity
  end

  it 'identifies planet if passed gravity is correct' do
    expect(result(9.807).planet.key).must_equal :earth
  end

  it 'fails if passed gravity is wrong' do
    expect { result(220) }.must_raise Interactor::Failure
  end
end
