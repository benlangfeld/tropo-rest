%w{active_support/core_ext/class/attribute_accessors active_support/core_ext/object/blank json httparty logger}.each { |l| require l }

module TropoREST
  class << self
    def logger=(logger)
      [API, Troplets].each do |endpoint|
        endpoint.send :logger=, logger
      end
    end

    def tokens=(tokens)
      [[:tropo, API], [:troplets, Troplets]].each do |type, target|
        if token = tokens[type]
          if token.is_a? String
            target.voice_token = token
          elsif token.is_a? Hash
            target.voice_token = token[:voice]
            target.messaging_token = token[:messaging]
          end
        end
      end
    end

    def method_missing(method_name, *args, &block)
      API.send method_name, *args, &block
    end
  end

  class API
    include HTTParty

    cattr_accessor :logger, :voice_token, :messaging_token, :troplets_voice_token, :troplets_messaging_token

    base_uri 'https://api.tropo.com'
    SESSION_URI = '/1.0/sessions'

    # format :json
    # headers 'Accept' => 'application/json', 'content-type' => 'application/json'

    self.logger = Logger.new STDOUT
    self.logger.level = Logger::DEBUG
    debug_output self.logger

    class << self
      def originate(options = {})
        logger.info "Originating Tropo call with parameters #{options}"
        resp = request SESSION_URI, options, options[:channel]
        logger.info "Tropo origination responded with: #{resp.inspect}"
        resp
      end

      def fire_event(event_name, session_id)
        logger.info "Firing event #{event_name} into Tropo session #{session_id}"
        resp = request "#{SESSION_URI}/#{session_id}/signals", value: event_name
        logger.info "Tropo event trigger responded with: #{resp.inspect}"
        resp
      end

      def request(target, body, type = nil)
        options = options_with_token body, type
        logger.debug "Making request to #{target} with #{options.inspect}"
        get target, query: options
      end

      def options_with_token(options, type = :voice)
        options.merge! token: type && type.to_sym == :text ? messaging_token : voice_token
      end
    end
  end

  class Troplets < API
    base_uri 'http://troplets.tropo.com'

    class << self
      def say(to, message, options = {})
        logger.debug "Using Troplets to say #{message} to #{to}"
        options.merge! to: to, message: message
        resp = request '/say', options, options[:channel] == :voice ? :voice : :messaging
        logger.debug "Troplet#say responded with: #{resp.inspect}"
        resp
      end

      def voice_token=(token)
        self.troplets_voice_token = token
      end

      def voice_token; self.troplets_voice_token; end

      def messaging_token=(token)
        self.troplets_messaging_token = token
      end

      def messaging_token; self.troplets_messaging_token; end
    end
  end
end
