require 'interactor'
require_relative './validate_raw_path'
require_relative './validate_start_event'
require_relative './validate_finish_event'
require_relative './validate_path_consistency'
require_relative './simulate_event'
require_relative '../path'
require_relative '../simulation_result'

module SpaceshipMissionSimulator
  class Simulate
    include Interactor

    before { ValidateRawPath.call! context }

    def call
      context.result = build_new_result

      simulate_events_from_last_one do |prev_event|
        add_path_event prev_event
        validate_added_event!
        sum_total_fuel_weight prev_event
      end
    end

    private

    def validate_added_event!
      path_ctx = { path: path }
      ValidatePathConsistency.call! path_ctx
      ValidateStartEvent.call! path_ctx if path.start_event?
      ValidateFinishEvent.call! path_ctx if path.finish_event?
    end

    def add_path_event(prev_event)
      path.events.prepend prev_event
    end

    def build_new_result
      new_path = Path.new raw_data: pull_from_context(:raw_path), events: []
      SimulationResult.new path: new_path,
                           total_fuel_weight: 0,
                           initial_weight: pull_from_context(:initial_weight)
    end

    def path
      context.result.path
    end

    def pull_from_context(key)
      context.send(key).tap { context.delete_field key }
    end

    def simulate_event(raw_event_data, reserved_fuel_weight)
      SimulateEvent.call!(initial_weight: context.result.initial_weight,
                          raw_data: raw_event_data,
                          reserved_fuel_weight: reserved_fuel_weight).event
    end

    def simulate_events_from_last_one
      path.raw_data.reverse.inject(0) do |reserved_fuel_weight, raw_event_data|
        event = simulate_event raw_event_data, reserved_fuel_weight
        yield event
        reserved_fuel_weight + event.fuel_weight
      end
    end

    def sum_total_fuel_weight(event)
      context.result.total_fuel_weight += event.fuel_weight
    end
  end
end
