class Tournament < ApplicationRecord
  has_many :registrations, dependent: :destroy
  has_many :players, through: :registrations
  has_many :matches, dependent: :destroy
  has_many :results, dependent: :destroy

  validates :name, uniqueness: true, presence: true

  scope :active, -> { where(active: true) }
  scope :upcoming, -> { where('date > ?', Time.now) }
  scope :ongoing, -> { where('(finished IS FALSE OR finished IS NULL) AND date <= ? AND date >= ?', Time.now, Time.now - 6.hours) }
  scope :past, -> { where('started AND finished OR date < ?', Time.now - 6.hours) }
  scope :for_calendar, -> { where(active: true).where('date > ? AND date < ?', 2.weeks.ago, Date.today + 4.months) }
  scope :from_city, -> (city) { where("name ILIKE ? OR name ILIKE ? OR location ILIKE ? OR location ILIKE ?", "%#{ActiveRecord::Base.sanitize_sql_like(city)}%", "%#{ActiveRecord::Base.sanitize_sql_like(city.downcase)}%", "%#{ActiveRecord::Base.sanitize_sql_like(city)}%", "%#{ActiveRecord::Base.sanitize_sql_like(city.downcase)}%") }

  MAX_PAST_TOURNAMENTS_PER_PAGE = 20

  def self.search(search)
    if search
      sanitizedSearch = ActiveRecord::Base.sanitize_sql_like(search)
      # name location city ranking_string
      where("name ILIKE ? or location ILIKE ? or city ILIKE ?", "%#{sanitizedSearch}%", "%#{sanitizedSearch}%", "%#{sanitizedSearch}%")
    else
      :all
    end
  end

  def cancelled?
    !self.started and self.finished
  end

  def is_past?
    self.date < Time.now
  end

  def has_pools?
    self.number_of_pools.to_i > 0
  end

  def weekly?
    self.subtype == 'weekly'
  end

  def game_stations_count
    gs_count = 0
    self.registrations.where('game_stations is not NULL').each do |r|
      gs_count += r.game_stations
    end
    gs_count
  end

  def host
    User.find_by(username: self.host_username) if self.host_username.present?
  end

end
