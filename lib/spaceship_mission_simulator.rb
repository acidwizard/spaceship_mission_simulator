require_relative 'spaceship_mission_simulator/interactors/simulate'

module SpaceshipMissionSimulator
  def simulate_spaceship_mission!(initial_weight, raw_path)
    Simulate.call! initial_weight: initial_weight,
                   raw_path: raw_path
  end

  def print_spaceship_mission_result(*args)
    simulate_spaceship_mission!(*args).result.awesome_print
  rescue Interactor::Failure => e
    p "Error: #{e.context.message}"
  end
end
