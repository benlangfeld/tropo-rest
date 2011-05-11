require 'json'
require 'httparty'
require 'logger'
require 'singleton'

module TropoREST
  class API
    include HTTParty
    include Singleton

    attr_writer :logger

    def initialize
      @logger = Logger.new STDOUT
      @logger.level = Logger::WARN
    end

    def token=(token)
      self.class.default_params token: token
    end

    base_uri 'https://api.tropo.com'
    SESSION_URI = '/1.0/sessions'

    format :json
    headers 'Accept' => 'application/json', 'content-type' => 'application/json'

    def originate(options = {})
      @logger.debug "Originating Tropo call with parameters #{options}"
      resp = self.class.post SESSION_URI, body: options
      @logger.debug "Tropo origination responded with: #{resp.inspect}"
      resp
    end

    def fire_event(event_name, session_id)
      @logger.debug "Firing event #{event_name} into Tropo session #{session_id}"
      resp = self.class.post "#{SESSION_URI}/#{session_id}/signals", body: { value: event_name }
      @logger.debug "Tropo event trigger responded with: #{resp.inspect}"
      resp
    end
  end

  def self.method_missing(method_name, *args, &block)
    API.instance.send method_name, *args, &block
  end
end
