class Api::VenuesController < ApplicationController
  skip_before_filter :email_server, only: [:homeless]
  skip_before_filter :prepare_for_mobile, only: [:homeless]
  skip_before_filter :detect_email_omniauth, only: [:homeless]
  skip_before_filter :check_subdomain, only: [:homeless]
  def show
    render :json => {:error => false,
      :content => Venue.all.as_json(lat: params[:lat], lon: params[:lon], all: true),
      :total_people_aided => total_meals,
      :people_aided => weekly_progress[:current_progress],
      :weekly_goal => weekly_progress[:adjusted_total]}
  end

  def homeless
  	@venue = Venue.where(device_id: params[:device_id]).first
  	render json: @venue.to_json
  end
end
