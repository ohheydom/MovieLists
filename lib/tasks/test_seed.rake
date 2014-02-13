namespace :db do
  namespace :test do
    desc "fill test database with sample data"
    task populate: :environment do
      ActiveRecord::Base.establish_connection(ActiveRecord::Base.configurations['test'])
      Rake::Task["db:seed"].invoke
    end
  end
end
