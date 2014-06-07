class Match
  def initialize jsonMatch
    @players = jsonMatch['players']
    @radiant_win = jsonMatch['radiant_win']
    @duration = jsonMatch['duration']
    @match_id = jsonMatch['match_id']
    @tower_status_radiant = jsonMatch['tower_status_radiant']
    @tower_status_dire = jsonMatch['tower_status_dire']
    @barracks_status_radiant = jsonMatch['barracks_status_radiant']
    @barracks_status_dire = jsonMatch['barracks_status_dire']
    @first_blood_time = jsonMatch['first_blood_time']
    @positive_votes = jsonMatch['positive_votes']
    @negative_votes = jsonMatch['negative_votes']
    @radiant_team_id = jsonMatch['radiant_team_id']
    @radiant_team_name = jsonMatch['radiant_name']
    @dire_team_id = jsonMatch['dire_team_id']
    @dire_team_name = jsonMatch['dire_name']
    @picks_bans = jsonMatch['picks_bans']
  end



end