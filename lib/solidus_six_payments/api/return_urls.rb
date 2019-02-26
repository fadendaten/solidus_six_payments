module SolidusSixPayments
  class ReturnUrls
    attr_accessor :success_url, :fail_url

    def initialize
      @success_url = SolidusSixPayments.config.success_url
      @fail_url = SolidusSixPayments.config.fail_url
    end

    def to_hash
      {
        'ReturnUrls': {
          'success': @success_url,
          'fail': @fail_url
        }
      }
    end
    alias_method :to_h, :to_hash
  end
end
