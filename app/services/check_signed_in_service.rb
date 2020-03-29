class CheckSignedInService
  def self.redirect_if_not(current_user, spotify_path)
    redirect spotify_path if current_user.nil?
  end
end
