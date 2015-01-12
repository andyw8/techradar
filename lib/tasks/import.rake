namespace :import do
  desc "Import ThoughtWorks radars"
  task thoughtworks: :environment do
    ThoughtWorksImporter.run
  end
end
