class AddPermission < ApplicationJob
  queue_as :default

  def perform()
    puts "running"
    API_TOKEN = '9a99385b-2f25-4d5f-91b5-5abfc1c3a79a'
    heroku = PlatformAPI.connect_oauth(API_TOKEN)
    puts heroku.app.info(ENV['HEROKU_APP_NAME'])
    puts "end"
  end
end
