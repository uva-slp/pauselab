class PagesController < ApplicationController

	def index
	  @idea = Idea.new
	end

end
