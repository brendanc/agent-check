class LinksController < HitsController
    def index
        @links = Link.order("created_at DESC").all

        respond_to do |format|
            format.html # index.html.erb
            format.json { render json: @links }
          end
    end
    
    def new
        newSlug = get_link_slug
        newUrl = params[:url]

        @link = Link.new
        @link.url = newUrl
        @link.slug = newSlug
        @link.save!   

        respond_to do |format|
            format.json do
                render json: @link
            end
        end
    end
    
    def follow
        s = params[:slug]
        l = Link.where(:slug => s).first
        save_hit(l)
        redirect_to l.url
    end


    private
    def get_link_slug
        string_length = 5
        s = rand(36**string_length).to_s(36)
        if Link.exists?(slug: s)
            get_link_slug
        else
            s
        end
    end
end
