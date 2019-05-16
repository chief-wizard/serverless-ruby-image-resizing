# Dynamic image resizing with Ruby and Serverless framework

In this example, we set up a dynamic image resizing solution with AWS S3 and a Serverless framework function written in Ruby. We use [mini_magick gem](https://github.com/minimagick/minimagick) for image resizing.

## Ruby Version
We are requiring the use of Ruby 2.5.0 since our Serverless configuration specifies the Ruby 2.5
runtime _and_ there's an undocumented assumption that the Ruby version is 2.5.0 in the
serverless-ruby-package Serverless plugin that we're using. Don't worry though, as if you follow
the instructions below you'll be installing the correct Ruby.

## Pre-requisites

In order to deploy the function, you will need the following:

- API credentials for AWS with persmissions to manage S3, IAM and API Gateway
- [Node.js](https://nodejs.org/en/)
- [ruby-install](https://github.com/postmodern/ruby-install)
- [chruby](https://github.com/postmodern/chruby)

## Deploying the Serverless project

1. Make a .env file with your AWS credentials, as in .env.example
2. Deploy the Serverless project:

```
npm i -g serverless
ruby-install ruby-2.5.0
chruby ruby-2.5.0
bundle install --standalone --path vendor/bundle
npm install
source .env
sls deploy
```

## Example usage

```
https://XXX.execute-api.eu-west-1.amazonaws.com/dev/100x100/test.jpg
```
