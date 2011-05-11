require 'pry'
require 'tropo-rest'

module TropoREST
  class CLI
    def self.start
      print "Enter your Tropo app token for this session: "
      TropoREST.token = gets
      pry
    end
  end
end
