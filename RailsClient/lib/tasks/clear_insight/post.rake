namespace :clear_insight do
  desc 'post data to clear insight'

  task :post, [:minutes] => :environment do |t, args|
    puts args
    if args[:minutes].blank?
      ClearInsightService.new.entry
    else
      ClearInsightService.new.entry(true, args[:minutes].to_i)
    end
  end
end