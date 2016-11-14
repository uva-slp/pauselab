class PagesController < ApplicationController

  def ideas
  end

  def cookies_song
    if cookies[:likes] != nil
      @likes = cookies[:likes]
    else
      @likes = "oh no im nil"
    end
  end

end
