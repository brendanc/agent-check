class HitsController < ApplicationController
  # GET /hits
  # GET /hits.json
  def index
    @hits = Hit.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @hits }
    end
  end


  def create
    @hit = Hit.new
    @hit.ip =  request.remote_ip || ''
    @hit.agent = request.env['HTTP_USER_AGENT'] || ''
    @hit.referrer = request.env["HTTP_REFERER"] || ''
    @hit.code = params[:code] || ''
    @hit.all_headers = ''
    request.env.each do |header|
      key = header[0]
      val = header[1].to_s
      @hit.all_headers << key + " :: " + val + "<br />"
    end
    @hit.all_headers << requst.user_agent
    @hit.save!
    return_type = params[:type] || 'img'
    
    if return_type == 'img'
      send_file Rails.root.join('app/assets/images/spacer.gif'), :disposition => 'inline'
    end
    
    if return_type == 'css'
      send_file Rails.root.join('app/assets/stylesheets/blank.css'), :disposition => 'inline'
    end
  end

  def clear
    Hit.destroy_all
    redirect_to(:action => 'index', :notice => 'Hits were successfully cleared.')
  end
end
