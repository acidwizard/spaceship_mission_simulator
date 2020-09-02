require 'awesome_print'

module SpaceshipMissionSimulator
  RESULT_ATTRS = %i[initial_weight total_fuel_weight path].freeze

  SimulationResult = Struct.new(*RESULT_ATTRS, keyword_init: true) do
    def awesome_print
      with_suppressed_warnings do
        ap ["path: #{path.print}",
            "weight of equipment: #{initial_weight} kg",
            "weight of fuel: #{total_fuel_weight} kg",
            "arguments: #{initial_weight}, #{path.raw_data}"]
      end
    end

    private

    def with_suppressed_warnings
      original_verbose = $VERBOSE
      $VERBOSE = nil
      yield
      $VERBOSE = original_verbose
    end
  end
end
