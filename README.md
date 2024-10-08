# rubypostal

`rubylibpostal` is a Ruby gem that provides seamless integration with the powerful [Libpostal](https://github.com/openvenues/libpostal) C library. It offers a clean and intuitive API for tasks related to address parsing and expansion.

## Features

- **Address Parsing:** Extracts components of an address, such as house number, road, city, state, etc.
- **Address Expansion:** Expands an address string into its possible variations (useful for normalizing addresses).

## Installation

Ensure that you have [Libpostal](https://github.com/openvenues/libpostal) installed on your system. You can follow [Libpostal's installation guide](https://github.com/openvenues/libpostal#installation) to set it up.

Once Libpostal is installed, you can add this line to your Gemfile:

```ruby
gem 'rubylibpostal'
```

And then execute:

```bash
$ bundle install
```

Alternatively, install the gem directly using:

```bash
$ gem install rubylibpostal
```

## Usage

### Address Parsing

To parse an address, simply call the `Rubypostal.parse_address` method:

```ruby
require 'rubylibpostal'

address = "781 Franklin Ave Crown Heights Brooklyn NYC NY 11216 USA"
parsed = RubyPostal.parse_address(address)

puts parsed
# => {
#      "house_number" => "781",
#      "road" => "franklin ave",
#      "suburb" => "crown heights",
#      "city_district" => "brooklyn",
#      "state" => "ny",
#      "postcode" => "11216",
#      "country" => "usa"
#    }
```

### Address Expansion

To expand an address into its possible variations:

```ruby
require 'rubylibpostal'

address = "781 Franklin Ave, Brooklyn, NYC"
expanded = RubyPostal.expand_address(address)

puts expanded
# => ["781 franklin avenue brooklyn new york city", "781 franklin avenue nyc"]
```

### Configuration

If you want to configure Libpostal initialization (e.g., deciding when `libpostal_setup` should run), you can set up custom configurations in your application as needed by modifying the gem's initialization block.

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `rake test` to run the tests.

To install this gem onto your local machine, run:

```bash
$ bundle exec rake install
```

To release a new version, update the version number in `lib/rubylibpostal/version.rb`, and then run:

```bash
$ bundle exec rake release
```
## TODO
1. [x] Write wrapper for the `exapand_address` and `parse_address` lib methods
2. [x] Clean up and push the rspec to upstream
3. [ ] Add the ability override the default configuration c-struct
  - [ ] Add override for `libpostal_get_address_parser_default_options`
  - [ ] Add override for `libpostal_get_default_options`
4. Fix the Github actions to autopublish the gem

## Contributing

Bug reports and pull requests are welcome on GitHub at [https://github.com/nijeesh4all/rubypostal](https://github.com/nijeesh4all/rubypostal). This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/nijeesh4all/rubypostal/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open-source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Authors

- **Nijeesh Joshy** – nijeesh.k@rently.com

---

This README should provide a solid introduction for anyone using or contributing to your `rubylibpostal` gem.
