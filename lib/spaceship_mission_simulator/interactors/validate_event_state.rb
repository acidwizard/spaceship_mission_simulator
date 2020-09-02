module SpaceshipMissionSimulator
  class ValidateEventState
    include Interactor

    def call
      event_state = context.raw_data.first.to_sym

      return true if Event.known_state?(event_state)

      context.fail! message: 'should be only land or launch'
    end
  end
end
