[![Codeship Status for andyw8/techradar](https://codeship.com/projects/591ae180-02f3-0132-c1a0-6602e923814a/status?branch=master)](https://app.codeship.com/projects/30336)

[![Dependency Status](https://dependencyci.com/github/andyw8/techradar/badge)](https://dependencyci.com/github/andyw8/techradar)

[![Code Climate](https://codeclimate.com/github/andyw8/techradar/badges/gpa.svg)](https://codeclimate.com/github/andyw8/techradar)

[![Coverage Status](https://coveralls.io/repos/github/andyw8/techradar/badge.svg?branch=master)](https://coveralls.io/github/andyw8/techradar?branch=master)

# techradar.io

This repo contains the Rails app behind [techradar.io](http://techradar.io),
a web app for building and sharing your own
[Technology Radar](https://www.thoughtworks.com/radar/faq).

# Dependencies

* Ruby
* Postgres

# Setup

1. Run `bin/setup`
2. Edit `.env` to configure the admin account.
3. Run `bin/rails server` to start the app.
4. Visit `http://localhost:3000`

# API

A preliminary JSON API is available (replace the UUID with your own):

[http://techradar.io/api/v1/radars/1f7af5fd-8c71-4a89-99e0-bb53b4e2e8c1](http://techradar.io/api/v1/radars/1f7af5fd-8c71-4a89-99e0-bb53b4e2e8c1)

(At present, you need to be logged in first).

## Contributing

1. Fork it ( https://github.com/andyw8/techradar/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
