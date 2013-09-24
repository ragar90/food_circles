module ApplicationHelper
  def google_maps_search(venue)
    return venue.google_maps_url if venue.google_maps_url.present?

    maps_base_uri = URI.parse "http://maps.google.com"
    search_terms = []
    search_terms << venue.name if venue.name
    search_terms << venue.address if venue.address
    search_terms << venue.city if venue.city
    search_terms << venue.state.name if venue.state && venue.state.name

    query = {
      :q => search_terms.join(", ")
    }
    maps_base_uri.query = query.to_query
    maps_base_uri.to_s
  end

  def get_name(user_id)

    @user_name = User.where("id = :id ", {:id => user_id.to_i})
    @user_name = @user_name[0][:name] if @user_name.present?


  end

  def get_offer(offer_id)

    @offer = Offer.where("id = :id ", {:id => offer_id.to_i})
    @offer = @offer[0][:name] if @offer.present?

  end
  
  def prettify_float(float)
    float.to_i == float ? float.to_i : float
  end
  
  def resource_name
      :user
    end

    def resource
      @resource ||= User.new
    end

    def devise_mapping
      @devise_mapping ||= Devise.mappings[:user]
    end

  def credit_card_class_map
    {
      "American Express" => "amex",
      "MasterCard" => "mastercard",
      "Visa" => "visa"
    }[current_user_credit_card_data.type] || "generic"
  end

  def facebook_share_url(title, summary, url = restaurants_url)
    facebook_sharing_uri = URI.parse "http://www.facebook.com/sharer/sharer.php"
    image_url =  URI.join "http://#{request.host}", "assets/", "logo_old.png"
    facebook_query = {
      :s => 100,
      :p => {
        :url => url,
        :images => {0 => image_url.to_s},
        :title => title,
        :summary => summary
      }
    }
    facebook_sharing_uri.query = facebook_query.to_query
    facebook_sharing_uri.to_s
  end

  def twitter_share_url(text, url = restaurants_url)
    twitter_sharing_uri = URI.parse "https://twitter.com/intent/tweet"

    twitter_query = {
      :text => text,
      :url => url
    }

    twitter_sharing_uri.query = twitter_query.to_query
    twitter_sharing_uri.to_s
  end
end

