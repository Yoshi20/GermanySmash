class Player < ApplicationRecord
  belongs_to :user, dependent: :destroy
  has_many :registrations, dependent: :destroy
  has_many :tournaments, through: :registrations

  def update_tournament_experience
    if self.participations == 0
      self.tournament_experience = 0 # None
    elsif self.participations < 5
      self.tournament_experience = 1 # A little
    elsif self.participations < 10
      self.tournament_experience = 2 # Some
    elsif self.participations < 30
      self.tournament_experience = 3 # A lot
    else
      self.tournament_experience = 4 # Very much
    end
    self.save
  end
end
