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
      redirect_to landingpages_path
    else
      flash[:error] = (t 'landingpages.save_error')
      render 'new'
    end
  end

  def edit
  end

  def update
    if @landingpage.update landingpage_params
      flash[:notice] = (t 'landingpages.save_success')
      if @landingpage.ideas_home?
        redirect_to ideas_home_path
      elsif @landingpage.artist_home?
        redirect_to artist_home_path
      elsif  @landingpage.steering_home?
        redirect_to steering_home_path
      elsif @landingpage.about?
        redirect_to about_path
      else
        redirect_to root_path
      end
    else
      flash[:error] = (t 'landingpages.save_error')
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
