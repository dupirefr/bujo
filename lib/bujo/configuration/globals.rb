module Configuration
  class Globals
    @@verbose = false

    def self.verbose
      @@verbose
    end

    def self.set_verbose(verbose)
      @@verbose = verbose
    end
  end
end