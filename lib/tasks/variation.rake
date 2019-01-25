namespace :variation do
  desc "全てのCounterのvariationを0にする"

  task :variation_reset => :environment do
    Counter.update_all(variation: 0)
  end
end
