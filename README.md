
[![Gem Version](https://badge.fury.io/rb/oas_parser_reborn.svg)](https://rubygems.org/gems/oas_parser_reborn)
[![Build Status](https://travis-ci.com/MarioRuiz/oas_parser_reborn.svg?branch=master)](https://github.com/MarioRuiz/oas_parser_reborn)
[![Coverage Status](https://coveralls.io/repos/github/MarioRuiz/oas_parser_reborn/badge.svg?branch=master)](https://coveralls.io/github/MarioRuiz/oas_parser_reborn?branch=master)
![Gem](https://img.shields.io/gem/dt/oas_parser_reborn)
![GitHub commit activity](https://img.shields.io/github/commit-activity/y/MarioRuiz/oas_parser_reborn)
![GitHub last commit](https://img.shields.io/github/last-commit/MarioRuiz/oas_parser_reborn)
![GitHub code size in bytes](https://img.shields.io/github/languages/code-size/MarioRuiz/oas_parser_reborn)  
This repository is a fork of [nexmo/oas_parser](nexmo/oas_parser) that is no longer maintained. So in case you want to contribute do it here.

---

# Open API Definition Parser

A Ruby parser for Open API Spec 3.0+ definitions.

### Install

Install the gem:

```
$ gem install oas_parser_reborn
```

Or add it to your Gemfile:

```ruby
gem 'oas_parser_reborn'
```

### Usage

Here is a basic example of how you can traverse through an Open API Spec 3 Definition:

```ruby
require 'oas_parser_reborn'

definition = OasParser::Definition.resolve('petstore.yml')
# => #<OasParser::Definition>

# Get a specific path
path = definition.path_by_path('/pets')
# => #<OasParser::Path>

# Get all paths.
definition.paths
# => [#<OasParser::Path>, ...]

# Get a specific endpoint by method
endpoint = path.endpoint_by_method('get')
# => #<OasParser::Endpoint>

# Get all endpoints
path.endpoints
# => [#<OasParser::Endpoint>, ...]

# Get endpoint description
endpoint.description
# => "Returns all pets from the system that the user has access to"
```

Checkout the tests and `lib` directory for more classes and methods.

### Development

Run tests:

```
$ rspec
```

### Publishing

Clone the repo and navigate to its directory:

```
$ cd oas_parser_reborn
```

Bump the latest version in `oas_parser_reborn/lib/oas_parser_reborn/version.rb`:

```
//old
module OasParser
  VERSION = '1.0.0'.freeze
end

//new
module OasParser
  VERSION = '1.1.0'.freeze
end
```

Build the gem:

```
$ gem build oas_parser_reborn.gemspec
```

_This will create a `oas_parser_reborn-1.1.0.gem` file._

Push the gem to rubygems.org:

```
$ gem push oas_parser_reborn-1.1.0.gem
```

Verify the change was made by checking for the [new version on rubygems.org](https://rubygems.org/gems/oas_parser_reborn)



## Contributing

Contributions are welcome, please follow [GitHub Flow](https://guides.github.com/introduction/flow/index.html)
