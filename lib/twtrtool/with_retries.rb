module Twtrtool
  module WithRetries
    MAX_RETRIES = 8
    RETRY_DELAY = 10
  
    def self.included(base)
      base.extend self
    end
  
    def with_retries
      num_tries = 0
      begin
        num_tries += 1
        yield
      rescue Twitter::Error::ServerError, Twitter::Error::TooManyRequests => err
        if num_tries < MAX_RETRIES
          delay = err.rate_limit.reset_in || RETRY_DELAY * num_tries
          location = caller[1].gsub("#{__dir__}/", "")
          puts "ERROR: \"#{err}\", retry ##{num_tries} in #{delay} seconds (#{location})"
          sleep(delay)
          retry
        else
          puts "Retried #{MAX_RETRIES} times, giving up."
          raise
        end
      end
    end
  end
end