module Heliosphere

  class DeamonCheck

    CHECK_INTERVAL = 60

    class << self
      def up?(port)
        set(port, port_up?(port)) if update?(port)
        @up[port][:state]
      end

      def down?(port)
        not up?(port)
      end

      def port_up?(port)
        `netstat -an` =~ /\b#{port}\b/m
      end

      private

      def set(port, state)
        @up ||= {}
        @up[port] = { time: Time.now.to_i, state: state }
      end

      def update?(port)
        !@up || !@up[port] || (Time.now.to_i - @up[port][:time] > CHECK_INTERVAL)
      end

    end
  end
end
