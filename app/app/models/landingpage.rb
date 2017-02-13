class Landingpage < ApplicationRecord
   require 'sanitize'
   before_save :sanitize_description
   
  	def sanitize_description
  		Sanitize.fragment(description, Sanitize::Config::RELAXED)
   	end
end
