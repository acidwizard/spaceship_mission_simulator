module SpaceshipMissionSimulator
  class ValidateRawPath
    include Interactor

    def call
      return true if context.raw_path.is_a?(Array)

      context.fail! message: 'should provide raw path as array of events'
    end
  end
end
