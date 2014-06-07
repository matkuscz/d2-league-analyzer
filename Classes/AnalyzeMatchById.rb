require './Classes/Team.rb'

class AnalyzeMatchById
  def initialize matchID,teams



    matchQuery = open('http://api.steampowered.com/IDOTA2Match_570/GetMatchDetails/V001/?match_id=' + matchID.to_s + '&key=6D504458E48AEA1BA380F5D26001CE5B')

    file = File.open(matchQuery)
    matchContents = File.open(file, 'rb') { |f| f.read }
    parsed_json_match = ActiveSupport::JSON.decode(matchContents)

    jsonMatch = parsed_json_match['result']

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





    team_radiant = Team.new(@radiant_team_id,@radiant_team_name)

    team_dire = Team.new(@dire_team_id,@dire_team_name)


    teams.addTeam(team_radiant)
    teams.addTeam(team_dire)






    puts @match_id
    puts @radiant_team_name
    puts @dire_team_name
    if @radiant_win
      if @radiant_team_name == nil
        puts 'Victory for UNKNOWN TEAM'
      else
      puts 'Victory for' + @radiant_team_name
      end

    else
      if @radiant_team_name == nil
        puts 'Victory for UNKNOWN TEAM'
      else
      puts 'Victory for ' + @dire_team_name
      end
    end

    both_teams = Array.new
    both_teams.push(team_dire,team_radiant)
    both_teams

  end


end