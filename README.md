# SmsMailer

SmsMailer is just a gem that let you define your own Rails mailer that sends SMS!

## Installation
1. Add `gem 'sms_mailer', github: 'jimanx2/sms_mailer'` into `Gemfile` and then update your bundle (`bundle install`)
2. Pick a name for your provider. For example: `isms`
3. Create appropriate files according to the following list (`isms` is your provider name as in #2):

```
    #RAILS_ROOT/config/providers/isms.yml
    #RAILS_ROOT/config/initializers/isms_provider.rb
		#RAILS_ROOT/config/initializers/sms_mailer.rb
```

## Defining Credentials

Your SMS gateway's credentials should be placed inside `#RAILS_ROOT/config/providers/isms.yml`. Minimum configuration:
```
username: <your sms gateway account username>
password: <your sms gateway account password>
```
If you need to provide environment based values, do it like this:
```
development:
    username: <your sms gateway account username>
    password: <your sms gateway account password>
```

## Defining Provider
You can place your provider anywhere as long it is in Rails $LOAD_PATH. But it's easier tu just put it in `#RAILS_ROOT/config/initializers/isms_provider.rb`

Structure of a provider is like the following:
```
class IsmsProvider < SmsMailer::Provider
    def initialize
        super
    end
    
    def deliver! mail
        # Do communication with API server of your SMS gateway here.
        # You might want to ready the documentation for API server of 
        # your SMS gateway.
    end
    
    def get_balance
        # Some API gateway provides an API endpoint to retrieve
        # your account\'s current balance.
        # You can do it here
    end
end
```

## How to use my provider?

Using the created provider is quite similar to [Rails ActionMailer Basics](http://guides.rubyonrails.org/action_mailer_basics.html)

1. First, generate your mailer `rails generate mailer MysmsMailer`
2. Then, in `#RAIL_ROOT/app/mailers/mysms_mailer.rb`, change/set the default `delivery_method` to `IsmsProvider`. Also, set the `content_type` to `text/plain`
3. Configure SmsMailer to load your provider and use it

```
#RAILS_ROOT/config/initializers/sms_mailer.rb
SmsMailer.configure do |config|
	config.provider = :isms
end
```
4. All that remain is to use `MysmsMailer` just like any other ActionMailer

## How to check balance?

Just use this snippet:
```
isms = SmsMailer.get_provider :isms # replace `isms` with your provider name
isms.get_balance                    # will query the API server (if get_balance is implemented)
```

## Contributing

I welcome any pull requests. Don't hesitate to contribute. :)
