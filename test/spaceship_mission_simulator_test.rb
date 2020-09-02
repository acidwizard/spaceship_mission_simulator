require 'test_helper'

describe SpaceshipMissionSimulator do
  class SpaceshipControlCenter
    include SpaceshipMissionSimulator
  end

  def subject
    SpaceshipControlCenter.new
  end

  it 'responds to #simulate_spaceship_mission!' do
    expect(subject).must_respond_to :simulate_spaceship_mission!
  end

  it 'responds to #print_spaceship_mission_result' do
    expect(subject).must_respond_to :print_spaceship_mission_result
  end

  describe 'when #simulate_spaceship_mission!' do
    def result(initial_weight, raw_path)
      subject.simulate_spaceship_mission!(initial_weight, raw_path).result
    end

    it 'includes path' do
      raw_path = [[:launch, 9.807], [:land, 9.807]]
      path_klass = SpaceshipMissionSimulator::Path
      expect(result(28_801, raw_path).path).must_be_instance_of path_klass
    end

    it 'includes total fuel weight' do
      raw_path = [[:launch, 9.807], [:land, 9.807]]
      expect(result(28_801, raw_path).total_fuel_weight).must_be :positive?
    end
  end
end
