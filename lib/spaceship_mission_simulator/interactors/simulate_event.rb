require 'interactor'

require_relative './validate_initial_weight'
require_relative './validate_event_data'
require_relative './validate_event_state'
require_relative './identify_planet'
require_relative '../event'

module SpaceshipMissionSimulator
  class SimulateEvent
    include Interactor

    before do
      context.reserved_fuel_weight ||= 0

      ValidateInitialWeight.call! context
      ValidateEventData.call! context
      ValidateEventState.call! context
    end

    def call
      context.event = build_event
      context.event.planet = identify_planet
      context.event.fuel_weight = calc_fuel
    end

    private

    def build_event
      Event.new state: context.raw_data.first.to_sym,
                reserved_fuel_weight: context.reserved_fuel_weight
    end

    def calc_fuel(mass = total_weight)
      fuel = calc_fuel_by_event_formula mass, context.event.planet.gravity

      return 0 unless fuel.positive?

      calc_fuel(fuel) + fuel
    end

    def calc_fuel_by_event_formula(mass, gravity)
      if context.event.state == :land
        (mass * gravity * 0.033 - 42).to_i
      elsif context.event.state == :launch
        (mass * gravity * 0.042 - 33).to_i
      end
    end

    def identify_planet
      IdentifyPlanet.call!(gravity: context.raw_data.last).planet
    end

    def total_weight
      context.initial_weight + context.reserved_fuel_weight
    end
  end
end
