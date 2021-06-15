class EmailController < ApplicationController
    def index
      @sample_image =  generate_sample_image
      @sample_link = generate_sample_link
    end

    private 
    
    def generate_sample_image
      placeholderH = (rand(1..8) * 100).to_s
      placeholderW = (rand(1..8) * 100).to_s
      placeholderDomains = ["placekitten.com","unsplash.it","placeimg.com",
        "placebear.com","p-hold.com","placedog.net",
        "www.fillmurray.com", "loremflickr.com", "placebeard.it"]

      return "https://" + placeholderDomains.sample() + "/" + placeholderH + "/" + placeholderW
    end

    def generate_sample_link
      Link.order("RANDOM()").first
    end
  
  end
  