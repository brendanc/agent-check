class CurrentController < ApplicationController
  def ip
    @current_ip = request.remote_ip || ''
  end
end
