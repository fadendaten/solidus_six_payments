module SolidusSixPayments
  class Terminal
    attr_accessor :terminal_id

    def initialize
      @terminal_id = SolidusSixPayments.config.terminal_id
    end

    def to_hash
      {
        "TerminalID": @terminal_id
      }
    end
    alias_method :to_h, :to_hash
  end
end
