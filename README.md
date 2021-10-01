# README

# Nomic cryptocurrency api

## Installation

Requirements:

* Node v14 [How to install](https://nodejs.org/download/)
* Ruby 2.2.7 [How to install](https://gorails.com/setup/osx/10.10-yosemite)
* PostgreSQL

Install global dependencies:

    gem install bundler

Install project dependencies:

    bundle install
    npm install OR yarn install

## Create File config/master.key and add the master_key in it
## Usage

To start the application, run:

```
First terminal tab
bundle exec rails server
second terminal tab
./bin/webpack-dev-server
```

### End Points used
1. List Currencies
```
# End point tested with different ids & attribute values
https://api.nomics.com/v1/currencies/ticker?key=#{API_KEY}&ids=BTC,ETH,XRP&attributes=id,name,log
```
2. Currency with specific fiat

```
# End point tested with different id values [BTC, ETH, XRP] & conversion value(fiat) [USD, EUR, ZAR]
# End point test with hard coded default time span (&start=2018-04-14T00%3A00%3A00Z&end=2018-05-14T00%3A00%3A00Z)

https://api.nomics.com/v1/currencies/sparkline?key=#{API_KEY}&ids=BTC&start=2018-04-14T00%3A00%3A00Z&end=2018-05-14T00%3A00%3A00Z&convert=EUR
```
