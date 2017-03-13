class LandingpagesController < ApplicationController

  load_and_authorize_resource

  def new
    @landingpage = Landingpage.new
  end

  def create
    @landingpage = Landingpage.new(landingpage_params)
    if @landingpage.save
    	flash[:notice] = (t 'landingpages.save_success')
    	redirect_to root_path
    end
  end

  def edit
    @landingpage = Landingpage.find params[:id]
  end

  def update
    @landingpage = Landingpage.find(params[:id])
    if @landingpage.update landingpage_params
      redirect_to root_path
      #if @landingpage.title == 'Home'
      #  redirect_to root_path
      #elsif @landingpage.title == 'Artist'
      #  redirect_to artist_home_url
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
