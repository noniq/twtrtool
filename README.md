# Twtrtool

twtrtool is a small command line utility helping you to manage your Twitter lists.

Right now, it only supports a single command:

*  `twtrtool create_inverse <listname>` – create an inverse for the given list (a list containing all the people you are following that are not part of the given list)
  

## Installation

Install the gem with:

    $ gem install twtrtool

twtrtool needs OAuth credentials to use the Twitter API. Therefore you need to register it with Twitter at  [https://dev.twitter.com/apps/new](https://dev.twitter.com/apps/new) (don’t forget to set the application type to "Read and Write" after you registered it). 

twtrtool can read the credentials from its config file (`~/.twtrtool`) or from environment variables, so you may either …

… let twtrtool create the config file for you:

    $ twtrtool auth   # ask for credentials and save in config file

… or manually set the following environment variables:

    TWITTER_CONSUMER_KEY
    TWITTER_CONSUMER_SECRET
    TWITTER_OAUTH_TOKEN
    TWITTER_OAUTH_TOKEN_SECRET

## Usage

After setting the the credentials you can use all other twtrtool commands. To see the complete list run:

    $ twtrtool help   # show all twtrtool commands

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
