[![Build Status](https://travis-ci.org/amogil/url_regex.svg?branch=master)](https://travis-ci.org/amogil/url_regex)
[![Code Climate](https://codeclimate.com/github/amogil/url_regex/badges/gpa.svg)](https://codeclimate.com/github/amogil/url_regex)
[![Gem Version](https://badge.fury.io/rb/url_regex.svg)](https://badge.fury.io/rb/url_regex)
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

Get the regex:

    UrlRegex.get(options)
    
where options are:

- `scheme_required` indicates that schema is required, defaults to `true`.

- `mode` can gets either `:validation` or `:parsing`, defaults to `:validation`.

`:validation` asks to return the regex for validation, namely, with `\A` prefix, and with `\z` postfix.
That means, it matches whole text:

    UrlRegex.get(mode: :validation).match('https://www.google.com').nil?
    # => false
    UrlRegex.get(mode: :validation).match('link: https://www.google.com').nil?
    # => true
    
`:parsing` asks to return the regex for parsing:

    str = 'links: google.com https://google.com?t=1'
    str.scan(UrlRegex.get(mode: :parsing))
    # => ["https://google.com?t=1"]
        
    # schema is not required
    str.scan(UrlRegex.get(scheme_required: false, mode: :parsing))
    # => ["google.com", "https://google.com?t=1"]

`UrlRegex.get` returns regular Ruby's [Regex](http://ruby-doc.org/core-2.0.0/Regexp.html) object,
so you can use it as usual.

All regexes are case-insensitive.

## FAQ

Q: Hey, I want to parse HTML, but it doesn't work:
    
    str = '<a href="http://google.com?t=1">Link</a>'
    str.scan(UrlRegex.get(mode: :parsing))
    # => "http://google.com?t=1">Link</a>"
    
A: Well, you probably know that parsing HTML with regex is 
[a bad idea](https://stackoverflow.com/questions/1732348/regex-match-open-tags-except-xhtml-self-contained-tags).
It requires matching corresponding open and close brackets, that makes the regex even more complicated.

Q: How can I speed up processing?

A: Generated regex depends only on options, so you can get the regex only once and cache it. 

## Contributing

1. Fork it ( https://github.com/[my-github-username]/url_regex/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request