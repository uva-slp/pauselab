require 'factory_girl'

namespace :populate do

  # TODO: make a script that populates fake ideas

  desc "populate database with Faker categories"
  task category: :environment do
    printf "generating categories... "
    Category.destroy_all
    5.times do
      i = FactoryGirl.create :category
    end
    printf "done\n"
  end

  desc "populate database with Faker data"
  # task :idea, [:count] => [:environment] do |t, args|
  task idea: :environment do
    printf "generating ideas... "
    Idea.destroy_all
    cur = Iteration.get_current
    30.times do
      FactoryGirl.create :idea,
        :iteration => cur,
        :status => :approved,
        :category => Category.order("RAND()").first
    end
    printf "done\n"
  end

  desc "populate database with Faker users"
  task user: :environment do
    printf "generating users... "
    User.where.not(:id => 6).destroy_all
    10.times do
      FactoryGirl.create :user
      # puts "#{f.fullname}"
    end
    printf "done\n"
  end

  desc "populate database with Faker blogs"
  task blog: :environment do
    printf "generating blogs... "
    Blog.destroy_all
    cur = Iteration.get_current
    10.times do
      FactoryGirl.create :blog,
        :iteration => cur,
        :user => User.where.not(:id => 6).order("RAND()").first
    end
    printf "done\n"
  end

  desc "populate database with Faker proposals"
  task proposal: :environment do
    printf "generating proposals... "
    Proposal.destroy_all
    cur = Iteration.get_current
    10.times do
      FactoryGirl.create :proposal,
        :iteration => cur,
        :status => :approved,
        :user => User.where.not(:id => 6).order("RAND()").first
    end
    printf "done\n"
  end

  desc "populate database with Faker proposal comments"
  task comment: :environment do
    printf "generating proposal comments ... "
    ProposalComment.destroy_all
    10.times do
      FactoryGirl.create :proposal_comment,
        :proposal => Proposal.order("RAND()").first,
        :user => User.where.not(:id => 6).order("RAND()").first
    end
    printf "done\n"
  end


  desc "remove Faker data from database"
  task remove: :environment do
    Idea.destroy_all
    Proposal.destroy_all
    Blog.destroy_all
  end

end
