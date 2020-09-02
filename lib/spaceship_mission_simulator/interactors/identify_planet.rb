require 'interactor'
require_relative '../planet'

module SpaceshipMissionSimulator
  class IdentifyPlanet
    include Interactor

    before { permit_gravity_arg! }

    def call
      context.planet = Planet.new(gravity: context.gravity).fill_up_data
    end

    private

    def permit_gravity_arg!
      return true if Planet.known_gravity?(context.gravity)

      msg = "fail to identify planet with '#{context.gravity}' gravity"
      context.fail! message: msg
    end
  end
end
