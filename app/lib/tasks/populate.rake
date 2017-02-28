namespace :populate do

  # TODO: make a script that populates fake ideas

  desc "populate database with Faker data"
  task :idea, [:count] => [:environment] do |t, args|
    puts "generating ideas ..."
    Idea.delete_all

    puts args.count
  end


  desc "remove Faker data from database"
  task remove: :environment do
  end

end
