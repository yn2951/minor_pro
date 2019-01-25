# config/schedule.rb
# cronログを吐き出す場所
set :output, File.join(Whenever.path, "log", "cron.log")
# ジョブの実行環境の指定
set :environment, :development
