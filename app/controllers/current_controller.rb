class CurrentController < ApplicationController
  def ip
    @current_ip = request.remote_ip || ''
    @city = request.location.city
    @region = request.location.region
    @country = request.location.country
  end
end
