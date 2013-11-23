require "twtrtool/list"
require "twtrtool/version"
require "yaml"

module Twtrtool
  class InvalidCredentialsError < StandardError; end
  
  CONFIG_FILE = "~/.twtrtool".freeze
  
  class << self
    def save_credentials(consumer_key, consumer_secret, oauth_token, oauth_token_secret)
      creds = { consumer_key: consumer_key, consumer_secret: consumer_secret, oauth_token: oauth_token, oauth_token_secret: oauth_token_secret }
      File.open(File.expand_path(CONFIG_FILE), 'w', 0600) do |file|
        file.write(YAML.dump(credentials: creds))
      end
    end
    
    def verify_credentials
      creds = YAML.load_file(File.expand_path(CONFIG_FILE)).fetch(:credentials)
      Twitter.configure do |config|
        config.consumer_key = creds[:consumer_key]
        config.consumer_secret = creds[:consumer_secret]
        config.oauth_token = creds[:oauth_token]
        config.oauth_token_secret = creds[:oauth_token_secret]
      end
      Twitter.verify_credentials(skip_status: true)
      return true
    rescue Errno::ENOENT, Twitter::Error::Forbidden, Twitter::Error::Unauthorized
      return false
    end
  end
end


