# Markio

A Ruby Gem for parsing [Netscape Bookmark File Format](http://msdn.microsoft.com/en-us/library/aa753582\(v=vs.85\).aspx)

[![Build Status](https://travis-ci.org/spajus/markio.png)](https://travis-ci.org/spajus/markio)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'markio'
```

And then execute:

```bash
$ bundle
```

Or install it yourself as:

```bash
$ gem install markio
```

## Usage

### Parsing bookmarks file

```ruby
bookmarks = Markio::parse(File.open('/path/to/bookmarks.html'))
bookmarks.each do |b|
  b.title           # String
  b.href            # String with bookmark URL
  b.folders         # Array of strings - folders (tags)
  b.add_date        # DateTime
  b.last_visit      # DateTime
  b.last_modified   # DateTime
end
```

### Building bookmarks file

```ruby
builder = Markio::Builder.new
builder.bookmarks << Markio::Bookmark.create({
  :title => "Google",
  :href => "http://google.com"
})
file_contents = builder.build_string
File.open('/path/to/bookmarks.html', 'w') { |f| f.write file_contents }
```

## TODO

  - Builder output to file
  - Builder should not ignore bookmark folders

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
