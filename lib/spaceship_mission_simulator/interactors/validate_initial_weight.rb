module SpaceshipMissionSimulator
  class ValidateInitialWeight
    include Interactor

    def call
      return true if context.initial_weight.to_i.positive?

      context.fail! message: 'should provide positive initial weight'
    end
  end
end
