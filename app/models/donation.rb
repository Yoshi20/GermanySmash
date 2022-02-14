class Donation < ApplicationRecord
  before_create :set_country_code

  scope :all_de, -> { where(country_code: 'de') }

end
