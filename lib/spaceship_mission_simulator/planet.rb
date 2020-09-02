module SpaceshipMissionSimulator
  AVAILABLE_PLANETS = {
    earth: 9.807, moon: 1.62, mars: 3.711
  }.freeze

  Planet = Struct.new(:gravity, :key, :name, keyword_init: true) do
    def self.known_gravity?(gravity)
      AVAILABLE_PLANETS.value? gravity
    end

    def fill_up_data
      tap do |planet|
        planet.key = AVAILABLE_PLANETS.key gravity
        planet.name = key.to_s.capitalize
      end
    end
  end
end
