module SolidusSixPayments
  class Configuration
    def self.config
      yield(self)
    end

    def error_handlers
      @error_handlers ||= []
    end
  end
end
