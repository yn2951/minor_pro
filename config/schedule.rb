set :output, File.join(Whenever.path, "log", "cron.log")
set :environment, :development

every 1.minutes do
  runner "Counter.totalize_reset"
end
