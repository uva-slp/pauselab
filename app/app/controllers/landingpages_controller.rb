class LandingpagesController < ApplicationController
  load_and_authorize_resource

  def index
  end

  def new
  end

  def create
    @landingpage = Landingpage.new(landingpage_params)
    if @landingpage.save
    	flash[:notice] = (t 'landingpages.save_success')
    	redirect_to root_path
    end
  end

  def edit
  end

  def update
    if @landingpage.update landingpage_params
      if @landingpage.title == 'Home'
        redirect_to root_path
      elsif @landingpage.title == 'Artist Home'
        redirect_to artist_home_path
      elsif  @landingpage.title == 'Steering Committee Home'
        redirect_to steering_home_path
      elsif @landingpage.title == 'About Us'
        redirect_to about_path
      else
        redirect_to root_path
      end
    else
      render 'edit'
    end

  end

  private
  def landingpage_params
    params.require(:landingpage).permit(
      :title,
    	:description
    	)
  end

end
