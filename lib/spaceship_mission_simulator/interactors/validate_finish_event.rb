module SpaceshipMissionSimulator
  class ValidateFinishEvent
    include Interactor

    def call
      event = context.path.events.last

      return true if event.planet.key == :earth && event.state == :land

      msg = 'spaceship mission should finish only by land on Earth'
      context.fail! message: msg
    end
  end
end
