# lita-meme

lita-meme allows you to autogenerate memes

## Installation

Add lita-meme to your Lita instance's Gemfile:

``` ruby
gem "lita-meme"
```

## Configuration

You need to add an imgflip username and password to your config. https://imgflip.com/signup

Then, in your `lita_config.rb`:
```
config.handlers.meme.username = "YOURUSERNAME"
config.handlers.meme.password = "YOURPASSWORD"
```

## Usage

`lita generate all the memes`
> [URL to your generated meme image]

`lita meme list` for a list of accepted templates
