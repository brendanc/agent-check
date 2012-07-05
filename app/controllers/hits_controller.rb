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

    @hit.save!
    send_file Rails.root.join('app/assets/images/spacer.gif'), :disposition => 'inline'
  end

  def clear
    Hit.destroy_all
    redirect_to(:action => 'index', :notice => 'Hits were successfully cleared.')
  end
end
