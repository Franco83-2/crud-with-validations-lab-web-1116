class Song < ActiveRecord::Base
  validates :title, presence: true
  validates :released, inclusion: { in: [ true, false ] }
  validates :artist_name, presence: true
  validates :release_year, presence: true, if: :released?
  validates :release_year, numericality: {less_than: Time.new.year}, if: :released?
  validate :confirm_unique_title

  def released?
    released == true
  end

  def confirm_unique_title
    Song.all.each do |song|
      if song.title == title && song.release_year == release_year
         errors.add(:title, "Title is already used this year, loser")
      end
    end
    return true
  end

end
