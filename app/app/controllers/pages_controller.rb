class PagesController < ApplicationController

  def go_home
    case Phase.get_current.phase
    when 'ideas'
      redirect_to :action => :ideas
    when 'proposals'
      redirect_to :action => :proposal_collection, :controller => :proposals
    when 'voting'
    when 'progress'
    else
      render :text => 'not in ideas'
    end
  end

  def ideas
  end

  def about
  end

  def test_email
    #SlpMailer.email_self.deliver_later
    SlpMailer.email_self.deliver
    flash[:notice] = "Your mail has been sent"
    redirect_to cookies_path
  end

  def cookies_song
    if cookies[:likes] != nil
      @likes = cookies[:likes]
    else
      @likes = "oh no im nil"
    end
  end

end
