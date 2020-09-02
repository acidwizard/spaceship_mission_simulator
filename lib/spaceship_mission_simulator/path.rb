module SpaceshipMissionSimulator
  Path = Struct.new(:raw_data, :events, keyword_init: true) do
    def fresh_event_consistent?
      finish_event? || events[0].state != events[1].state
    end

    def finish_event?
      events.size == 1
    end

    def start_event?
      events.size == raw_data.size
    end

    def print
      events.map { |event| "#{event.state} #{event.planet.name}" }.join ', '
    end
  end
end
