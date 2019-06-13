class HitsController < ApplicationController

before_action :set_cache_headers

  # GET /hits
  # GET /hits.json
  def index
    @hits = Hit.order("created_at DESC").all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @hits }
    end
  end


  def create
    cookies.permanent[:hitCount] = cookies[:hitCount].to_i + 1

    @hit = Hit.new
    @hit.ip =  request.remote_ip || ''
    @hit.agent = request.env['HTTP_USER_AGENT'] || ''
    @hit.referrer = request.env["HTTP_REFERER"] || ''
    @hit.code = params[:code] || ''
    @hit.all_headers = ''
    request.env.each do |header|      
      key = header[0]
      if key.start_with?('rack') || key.start_with?('action')
        next
      end
      val = header[1].to_s
      @hit.all_headers << key + " :: " + val + "<br />"
    end
    @hit.save!
    return_type = params[:t] 
    puts params
    puts return_type
    if return_type == '503'
      render :status => 503
    end

    if return_type == '404'
       raise ActionController::RoutingError.new('Not Found')
    end
    
    if return_type == 'img'
      send_file Rails.root.join('app/assets/images/litmus-icon.png'), :disposition => 'inline'
      return
    end
    
    if return_type == 'css'
      send_file Rails.root.join('app/assets/stylesheets/blank.css'), :disposition => 'inline'
      return
    end

    if return_type = 'dyn'
      dynamic_image
      return
    end

    # default to blank 1x1 gif
    send_file Rails.root.join('app/assets/images/spacer.gif'), :disposition => 'inline'
  end

  def clear
    Hit.destroy_all
    redirect_to(:action => 'index', :notice => 'Hits were successfully cleared.')
  end

  def dynamic_image
    t = Time.now
    kit = IMGKit.new('Hello world!  Current server time = ' + t.to_s)
    send_data(kit.to_jpg, :type => "image/jpeg", :disposition => 'inline')
  end

  private
    def set_cache_headers
      response.headers["Expires"] = ""
      response.headers["Cache-Control"] = "no-store, no-cache, must-revalidate, max-age=0, post-check=0, pre-check=0"
      response.headers["Pragma"] = "no-cache"     
    end

end
