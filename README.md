# Lego

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/lego`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'lego'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install lego


## Usage

- decide on the name of the app, e.g. 'cart'
- create a remote repository for the API code and one for the SPA code, e.g. 'cart-api' and 'cart-app'
- from the console, instantiate a MicroService object, create the projects and push the first commit

```bash
bin/console
ms = Lego::MicroService.new(name: 'cart', account: 'maxcole')
ms.create
ms.push
```


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/rjayroach/lego.
