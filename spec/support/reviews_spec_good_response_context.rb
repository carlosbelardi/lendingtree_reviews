# frozen_string_literal: true
# rubocop:disable Metrics/LineLength
# rubocop:disable Style/StringLiterals
shared_context :reviews_spec_good_response_context do
  let(:successful_response) do
    {
      "reviews": [
        {
          "title": "Excellent",
          "details": "I would like to say Thank you Bridget! Job well done. Every step of the way Bridget had my back. She really helped me keep the faith. I look forward to working with her in the future. I will recommend her to all of my friends and family.",
          "stars": 5,
          "author": "Christine",
          "date": "2021-12-01",
          "location": "Seabrook,  NH",
        },
        {
          "title": "Very easy process 5 star 🌟 plus 10",
          "details": "The entire process was pretty easy going, i got a call from Ritu Sethi and she sounded convincing, i was hesitant at first but she made me feel so confident i figured let me hear her out , so glad i did, i feel like she had so much knowledge very Courteous and so kind , always returned my calls in a timely manner , was on top of everything, anyone looking for any mortgage related things please call Ritu Sethi you won’t be disappointed, trust me . She’s an asset to the company and they would be crazy to ever let her go . I would love to meet her in person she’s a wonderful lady ,all in all a great lady who knows her stuff . Two 👍 👍to her thanks again Ritu from Tammy in New York",
          "stars": 5,
          "author": "Tammy",
          "date": "2021-12-01",
          "location": "Stone Ridge,  NY",
        },
        {
          "title": "Refinancing",
          "details": "My husband and I were refinancing to make an addition to our home.  Regina discussed financial options that I never knew about.  We were able to refinance, pay off all my school loans and have cash out.  Regina was professional, kind and very dedicated to our needs.  Thank you so muych Regina for helping us!",
          "stars": 5,
          "author": "Alisa",
          "date": "2021-12-01",
          "location": "Roanoke,  VA",
        },
        {
          "title": "It was an excellent, seamless, transparent experience. I highly recommend working with Christina.",
          "details": "The entire process was great. Everything was thoroughly explained. Each step was seamless and transparent. I understood the process like I was an expert after every communication. I trusted Christina and her team fully. They made away for me and family to finally own a home. I am so blessed to have worked with an amazing team that has changed the trajectory of my life now that I am a home owner. I can’t thank them enough! Thank you so much!",
          "stars": 5,
          "author": "Brandi",
          "date": "2021-12-01",
          "location": "Cleveland,  OH",
        },
        {
          "title": "Great experience.",
          "details": "The whole process was made easy and pleasant by the fact we were working with Bridget.  She was knowledgeable and communicative and she and her team got the job done with a minimum of fuss.",
          "stars": 5,
          "author": "Jim",
          "date": "2021-12-01",
          "location": "West Kill,  NY",
        },
        {
          "title": "Top notch service",
          "details": "What a pleasure to have Ajmall guiding us in our refi process. His expert navigation and knowledge made the whole process simple and easy.",
          "stars": 5,
          "author": "Dennis",
          "date": "2021-12-01",
          "location": "Niagara Falls,  NY",
        },
        {
          "title": "Amazing and Professional",
          "details": "Ritu Sethi is exceptionally knowledgeable, friendly, courteous, kind, respectful, very innovative and very professional.  Ritu and I built a confidence between us, understood what was necessary to get the job done and got the job done! Thank you Ritu for all your hard work. Ritu will get a referral from me everytime with family/friends that are interested in mortgage, financial services,  or refinancing.",
          "stars": 5,
          "author": "Leanne",
          "date": "2021-12-01",
          "location": "Boston,  NY",
        },
        {
          "title": "It was a pleasure working with Courtney.",
          "details": "Courtney was professional, knowledgeable, and detail oriented which made the process of refinancing streamlined. She communicated with us throughout the process, helping us stay on track. I would recommend Courtney to anyone interested in a mortgage or refinancing.",
          "stars": 5,
          "author": "Larry R. Stevens",
          "date": "2021-11-01",
          "location": "Millsboro,  DE",
        },
        {
          "title": "Outstanding support through the entire process",
          "details": "I was very fortunate to have found Lori to work with me through my home refinance. She provided outstanding advice on how to proceed and also advised me to do work on my end to make a better presentation of my Financial status. She worked very quickly to get everything packaged so we could lock in a rate before rates started to increase. Lori is very knowledgeable, forthright outgoing and resourceful. She worked very hard at securing us a great rate along with ample cash-out to solve our COVID financial hardships.  She is a Miracle Worker!",
          "stars": 5,
          "author": "Joseph",
          "date": "2021-11-01",
          "location": "Acton,  MA",
        },
        {
          "title": "Exceptional Service",
          "details": "The process was easy and very friendly. Always professional and made us feel like we were a dear friend. We were guided from the beginning until the end of the loan process.  When we didn't under stand something everything was explained with great patience.",
          "stars": 5,
          "author": "Ron",
          "date": "2021-11-01",
          "location": "Buffalo,  NY",
        },
      ],
    }
  end
end
# rubocop:enable Metrics/LineLength
# rubocop:enable Style/StringLiterals
