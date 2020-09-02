module SpaceshipMissionSimulator
  class ValidatePathConsistency
    include Interactor

    def call
      return true if context.path.fresh_event_consistent?

      msg = 'spaceship mission path should be consistent (launch -> land)'
      context.fail! message: msg
    end
  end
end
