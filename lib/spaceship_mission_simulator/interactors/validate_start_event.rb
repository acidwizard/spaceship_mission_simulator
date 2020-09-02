module SpaceshipMissionSimulator
  class ValidateStartEvent
    include Interactor

    def call
      event = context.path.events.first

      return true if event.planet.key == :earth && event.state == :launch

      msg = 'spaceship mission should start only by launch from Earth'
      context.fail! message: msg
    end
  end
end
