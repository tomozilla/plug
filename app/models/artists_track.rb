class ArtistsTrack < ApplicationRecord
  belongs_to :track
  belongs_to :artist

  dups = ArtistsTrack.group(:name).having('count("name") > 1').count(:name)

  dups.each do |key, value|
    # Keep one and return rest of the duplicate records

    duplicates = ArtistTrack.where(name: key)[1..value-1]
    puts "#{key} = #{duplicates.count}"
    duplicates.each(&:destroy)
  end
end
