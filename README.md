[![Build Status](https://travis-ci.org/amogil/url_regex.svg?branch=master)](https://travis-ci.org/amogil/url_regex)
[![Code Climate](https://codeclimate.com/github/amogil/url_regex/badges/gpa.svg)](https://codeclimate.com/github/amogil/url_regex)
[![GitHub version](https://badge.fury.io/gh/amogil%2Furl_regex.svg)](https://badge.fury.io/gh/amogil%2Furl_regex)
[![Dependency Status](https://gemnasium.com/badges/github.com/amogil/url_regex.svg)](https://gemnasium.com/github.com/amogil/url_regex)

# UrlRegex

Provides the best known regex for validating and extracting URLs.
It uses amazing job done by [Diego Perini](https://gist.github.com/dperini/729294) 
and [Mathias Bynens](https://mathiasbynens.be/demo/url-regex).

Why do we need a gem for this regex? 

- You don't need to watch changes and improvements of original regex.
- You have an ability to slightly customize the regex: a scheme can be optional, can get the regex for validation or parsing.

## Installation

Add this line to your application's Gemfile:

    gem 'url_regex'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install url_regex

## Usage


TODO: Write usage instructions here
+ parsing html
+ optimization


## Contributing

1. Fork it ( https://github.com/[my-github-username]/url_regex/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request