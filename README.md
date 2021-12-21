# LendingTree Reviews

## Setup

This was built using Rails 7.0.0 and Ruby 3.0.2

To get it up and running on your machine, (assuming you already have Ruby and Rails all set up) make sure you have bundler installed, if not you can run 
```
gem install bundler
```
Once that's set up, run the following
```
bundle install
```
This should get all other necessary gems set up for you. 

## Hitting the endpoint

First made sure you're in the app's directory on your terminal, then boot up a Rails server
```
rails s
```
Once that's started, you can use your preferred method to hit the endpoint (I like to use Postman)
```
http://localhost:3000/api/v1/reviews?url=https://www.lendingtree.com/reviews/mortgage/triumph-lending/44068646
```
A successfull response should look like the following: 
```
{
    "reviews": [
        {
            "title": "made the process easy and stress-free",
            "details": "Miguel was very knowledgeable. answered all my questions with understandable explanations. made the whole process less stressful than what i expected. responsiveness was immediate.",
            "stars": 5,
            "author": "Rebecca",
            "date": "2021-12-01",
            "location": "Dallas,  TX"
        },
        (further reviews would be listed after this one, cutting it short for the sake of readability)
    ]
}
```
Errors look like this
```
{
    "error": "URL is invalid or not for lendingtree.com"
}
```

## Testing 

Make sure you're in the app's directory. Then run
```
rspec spec/requests/api/v1/reviews_spec.rb
```
Everything should pass! 
