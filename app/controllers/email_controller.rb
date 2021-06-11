class EmailController < ApplicationController
    def index
      placeholderH = (rand(1..8) * 100).to_s
      placeholderW = (rand(1..8) * 100).to_s
      placeholderDomains = ["placekitten.com","unsplash.it","placeimg.com",
        "placebear.com","p-hold.com","placedog.net",
        "www.fillmurray.com", "loremflickr.com", "placebeard.it"]

      @sample_image =  "https://" + placeholderDomains.sample() + "/" + placeholderH + "/" + placeholderW

    end
  end
  