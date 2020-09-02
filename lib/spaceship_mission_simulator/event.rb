module SpaceshipMissionSimulator
  EVENT_STATES = %i[land launch].freeze
  EVENT_ATTRS  = %i[state planet reserved_fuel_weight fuel_weight].freeze

  Event = Struct.new(*EVENT_ATTRS, keyword_init: true) do
    def self.known_state?(state)
      EVENT_STATES.include? state
    end
  end
end
