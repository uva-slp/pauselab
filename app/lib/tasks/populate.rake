require 'factory_girl'

namespace :populate do

  # TODO: make a script that populates fake ideas

  desc "populate database with Faker data"
  # task :idea, [:count] => [:environment] do |t, args|
  task idea: :environment do
    printf "generating ideas... "
    # require File.expand_path("spec/factories.rb") # linking to defined factories in spec/
    Idea.delete_all
    cur = Iteration.get_current
    30.times do
      i = FactoryGirl.create :idea, :iteration => cur, :status => :approved
    end
    printf "done\n"
  end


  desc "remove Faker data from database"
  task remove: :environment do
    Idea.delete_all
  end

end
