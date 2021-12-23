# LendingTree Reviews

## Setup

This was built using Rails 7.0.0 and Ruby 3.0.2

To get it up and running on your machine, (assuming you already have Ruby and Rails all set up) make sure you have bundler installed, if not you can run 
```
gem install bundler
```
Once that's set up, run the following in the app's directory
```
bundle install
```
This should get all other necessary gems set up for you. 

## Hitting the endpoint

First made sure you're in the app's directory on your terminal, then boot up a Rails server:
```
rails s
```
Once that's started, you can use your preferred method to hit the endpoint with a GET request (I like to use Postman):
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
            "author": "Rebecca",
            "stars": 5,
            "date": "2021-12-01",
            "author_location": "Dallas,  TX"
        },
        {
            "title": "All around excellence",
            "details": "Although there are many choices when searching for lending, there will be no better loan officer than Colin Clark. Receptive, intelligent, with excellent follow up as well as readily available and accessible to any questions. He did not waste my time and because of his diligence and thoroughness our loan closed 8 days early. I cannot say enough about his work ethic or the product which he represents. Look no further if you are interested in a professional, well executed, and effort free loan process.",
            "author": "Kristine",
            "stars": 5,
            "date": "2021-12-01",
            "author_location": "Helotes,  TX"
        },
        (further reviews would be listed after this one, cutting it short for the sake of readability)
    ]
}
```
The response will tell you the following:
* Review title
* Review details
* Author of review
* Stars given
* Date of review
* Author's location

Errors look like this:
```
{
    "error": "URL is invalid or not for lendingtree.com"
}
```
You can also hit other pages of that same company's reviews by passing a modified URL such as:
```
https://www.lendingtree.com/reviews/mortgage/pacific-beneficial-mortgage-company/44396611?sort=&pid=4
```
This will return all reviews on the fourth page of the company's reviews. If you go too far and there are no reviews on that page, it'll return an error saying so.

## Testing 

Make sure you're in the app's directory. Then run
```
rspec spec/requests/api/v1/reviews_spec.rb
```
Everything should pass! 
