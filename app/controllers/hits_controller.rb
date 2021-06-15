class HitsController < ApplicationController

before_action -> {set_cache_headers},
                  only: [:create, :dynamic_image, :long_cache_image]

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
    # save the hit data
    puts params
    save_hit(nil)

    # figure out what to return
    use_cookie = params[:cook]
    if use_cookie != 'no'
      cookies.permanent[:hitCount] = cookies[:hitCount].to_i + 1
    end
    long_cache = params[:long_cache] == "true"
    return_type = params[:t] 
    puts return_type
    if return_type == '503'
      render :status => 503
    end

    if return_type == '404'
       raise ActionController::RoutingError.new('Not Found')
    end
    
    if return_type == 'img' and long_cache == true
      long_cache_image
      return
    end

    if return_type == 'img'
      # send_file_with_content_length Rails.root.join('public/images/litmus-icon.png'), :type => "image/png",:disposition => 'inline'
      redirect_image
      return
    end
    
    if return_type == 'css'
      send_file Rails.root.join('app/assets/stylesheets/blank.css'), :type => "text/css",:disposition => 'inline'
      return
    end

    if return_type == 'dyn'
      dynamic_image
      return
    end

    if return_type == 'eng'
      redirects = params[:r]
      rstatus = params[:st] || '302'
      puts "redirects = " + redirects.to_s
      if redirects.to_s.length > 9
        dynamic_image
        return
      else
        redirects_param = ''
        if redirects.to_s.length == 0
          redirects_param = '&r=0'
        else
          redirects_param = '0'
        end
        url = request.original_url + redirects_param 
        sleep 1
        puts "status = " + rstatus
        redirect_to url, status: rstatus
        return
      end

    end


    # default to blank 1x1 gif
    send_file Rails.root.join('app/assets/images/spacer.gif'), :type => "image/gif", :disposition => 'inline'
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

  def long_cache_image
    t = Time.now
    kit = IMGKit.new('Hello LONG CACHE world!  Current server time = ' + t.to_s)
    send_data(kit.to_jpg, :type => "image/jpeg", :disposition => 'inline')
  end

  def redirect_image
    redirect_to '/images/litmus-icon.png'
  end

  def destroy
    Hit.find(params[:id]).destroy
    respond_to do |format|

      format.html do
        redirect_to root_path, notice: "Hit was successfully deleted."
      end

      format.json do
        @hits = Hit.order("created_at DESC").all
        render json: @hits.all
      end

    end
  end

  protected
  def save_hit(link)
    l = link.nil? ? 'nil' : link.url
    puts "in save_hit and link = " + l
    @hit = Hit.new
    @hit.ip =  request.remote_ip || ''
    @hit.agent = request.env['HTTP_USER_AGENT'] || ''
    @hit.referrer = request.env["HTTP_REFERER"] || ''
    @hit.code = params[:code] || ''
    @hit.path = request.env["ORIGINAL_FULLPATH"] || ''
    @hit.all_headers = ''
    request.env.each do |header|      
      key = header[0]
      if key.start_with?('rack') || key.start_with?('action')
        next
      end
      val = header[1].to_s
      @hit.all_headers << key + " :: " + val + "<br />"
    end
    unless link.nil?
      @hit.link = link
    end
    @hit.save!
  end

  private
    def set_cache_headers()
      lc = params[:long_cache] == "true"
      puts 'in cache headers'
      puts 'long_cache = ' + lc.to_s
      if not lc
        response.headers["Expires"] = "Mon, 01 Jan 2021 00:00:00 GMT"
        response.headers["Cache-Control"] = "private, max-age=30"
        response.headers["Pragma"] = "no-cache"     
      else
        response.headers["Expires"] = "Mon, 01 Jan 2022 00:00:00 GMT"
        response.headers["Cache-Control"] = "max-age=30000000"
      end
    end

    def send_file_with_content_length(path, options = {})
      headers['Content-Length'] = File.size(path).to_s
      send_file(path, options)      
      remove_keys = %w(Content-Disposition Content-Transfer-Encoding Cache-Control)
      headers.delete_if{|key| remove_keys.include? key}
    end


end
