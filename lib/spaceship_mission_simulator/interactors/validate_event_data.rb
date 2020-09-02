module SpaceshipMissionSimulator
  class ValidateEventData
    include Interactor

    def call
      return true if correct_event_data?

      msg = 'should provide proper event format ([state, gravity])'
      context.fail! message: msg
    end

    private

    def correct_event_data?
      context.raw_data.is_a?(Array) && context.raw_data.size == 2
    end
  end
end
