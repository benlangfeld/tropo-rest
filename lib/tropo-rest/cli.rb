%w{pry tropo-rest}.each { |l| require l }

module TropoREST
  class CLI
    def self.start
      puts "Setting up your session..."

      tokens = {tropo: {voice: ARGV[0], messaging: ARGV[1]}, troplets: {voice: ARGV[2], messaging: ARGV[3]}}
      unless tokens[:tropo][:voice].present?
        print "Enter your Tropo voice token: "
        tokens[:tropo][:voice] = gets
      end
      unless tokens[:tropo][:messaging].present?
        print "Enter your Tropo messaging token: "
        tokens[:tropo][:messaging] = gets
      end
      unless tokens[:troplets][:voice].present?
        print "Enter your Troplets voice token: "
        tokens[:troplets][:voice] = gets
      end
      unless tokens[:troplets][:messaging].present?
        print "Enter your Troplets messaging token: "
        tokens[:troplets][:messaging] = gets
      end

      TropoREST.tokens = tokens
      pry
    end
  end
end
