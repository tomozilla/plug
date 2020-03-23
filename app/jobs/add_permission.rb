class AddPermission < ApplicationJob
  queue_as :default

  def perform()
    puts "running"
    heroku = PlatformAPI.connect_oauth(ENV['API_TOKEN'])
    puts heroku.app.info(ENV['HEROKU_APP_NAME'])
    puts "end"
  end
end
