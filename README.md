# Markio

A ruby gem for parsing Netscape Bookmark File Format
http://msdn.microsoft.com/en-us/library/aa753582(v=vs.85).aspx

## Installation

Add this line to your application's Gemfile:

    gem 'markio'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install markio

## Usage

    bookmarks = Markio::parse(File.open('/path/to/bookmarks.html'))
    bookmarks.each do |b|
      b.title           # String
      b.href            # String with bookmark URL
      b.folders         # Array of strings - folders (tags)
      b.add_date        # DateTime
      b.last_visit      # DateTime
      b.last_modified   # DateTime
    end

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
