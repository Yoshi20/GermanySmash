module PlayerHelper

  def self_assessment_defines
    t(['beginner', 'noob', 'doing_okay', 'intermediate', 'advanced', 'expert', 'professional', 'godlike'],
      scope: 'defines.self_assessments')
  end

  def tournament_experience_defines
    t(['none', 'a_little', 'some', 'a_lot', 'very_much'],
      scope: 'defines.tournament_experiences')
  end

  def federal_states_raw
    ['BB', 'BE', 'BW', 'BY', 'HB', 'HE', 'HH', 'MV', 'NI', 'NW', 'RP', 'SH', 'SL', 'SN', 'ST', 'TH']
  end

  def federal_states
    t(federal_states_raw, scope: 'defines.federal_states')
  end

  def federal_states_for_select
    federal_states.zip(federal_states_raw)
  end

  def genders_raw
    ['male', 'female', 'other']
  end

  def genders
    t(genders_raw, scope: 'defines.genders')
  end

  def genders_for_select
    genders.zip(genders_raw)
  end

  def birth_years
    year = Date.today.year
    ((year-100)..year).to_a.sort().reverse()
  end

  def seed_players(players)
    players.sort_by do |p|
      [p.seed_points, -p.created_at.to_i]
    end.reverse
  end

  def top_players_s12_21
    ['Jaka', 'Destany', 'DeepFreeze', 'Deox6', 'Crash', 'Phonky', 'Karpador64', 'Kimbo', 'PATOO', 'colinmee', 'mistic', 'Rohan Doge', 'SickBoy', 'Fr0zen', 'Bigniouf', 'Clipho', 'Mirio', 'Tuzzi', 'ItseMePG', 'Jodel']
  end

end
