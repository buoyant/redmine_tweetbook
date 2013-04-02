Redmine TweetBook plugin
================

Authentication in redmine through Facebook, Twitter, Github similar to existing OpenID Authentication.

Download the plugin to your application/root/folder/plugins directory. Be sure to maintain the correct folder name, ‘redmine_tweetbook’.

Configure your keys in config/settings.yml

Run ‘rake redmine:plugins:migrate RAILS_ENV=production’

Restart your redmine as appropriate (e.g., ‘rails s -e production’)

Tested on redmine version 2.1.4