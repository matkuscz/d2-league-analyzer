require 'open-uri'
require 'net/https'
require 'nokogiri'
require 'json'
require 'active_support'
require './Classes/Match.rb'
require './Classes/Player.rb'
require './Classes/LeagueBansPicks.rb'
require './Classes/AnalyzeMatchById.rb'
require './Classes/Downloader.rb'

class Main
  OpenURI::Buffer.send :remove_const, 'StringMax'
  OpenURI::Buffer.const_set 'StringMax', 0

  league_id = 1002
  download = false

  @all_matches_of_league = Array.new

  if download
    dwnldr = Downloader.new
    pl = dwnldr.download_list_of_league_matches league_id #cz/sk
    dwnldr.download_each_league_match pl
  end

  #parse basic Team info from matches
  #->team id, team name, players(5+),win/loss

  #nasat zapasy do pole
  matches_path = "./files/matches/#{league_id}/"
  Dir.foreach(matches_path) do |file|
    next if file == '.' or file == '..'
    match_file = File.open(matches_path + file.to_s)
    contents = ""
    match_file.each{ |line|
      contents << line
    }
    @all_matches_of_league << ActiveSupport::JSON.decode(contents)
  end
  puts @all_matches_of_league.inspect




  #projet zapasy a pridat z nich teamy do tabulky teamu
  #->team id, team name, players(5+),win/loss

  @bans = Array.new
  @teams = Teams.new


  test_team_A = Team.new(1234,'A')
  test_team_B = Team.new(1234,'A')


  #teams.addTeam test_team_A
  #teams.addTeam test_team_B

  @all_matches_of_league.each { |match|
    #puts match.to_s

    team_radiant = Team.new(match['result']['radiant_team_id'], match['result']['radiant_name'])
    @teams.addTeam(team_radiant)

    team_radiant.addPlayer(Player.new match['result']['players'][0]['account_id'].to_i)
    team_radiant.addPlayer(Player.new match['result']['players'][1]['account_id'].to_i)
    team_radiant.addPlayer(Player.new match['result']['players'][2]['account_id'].to_i)
    team_radiant.addPlayer(Player.new match['result']['players'][3]['account_id'].to_i)
    team_radiant.addPlayer(Player.new match['result']['players'][4]['account_id'].to_i)

    #i = 0
    #number_of_team_players = 5
    #
    #while i < number_of_team_players
    #  team_radiant.addPlayer(Player.new match['result']['players'][i]['account_id'].to_i)
    #  ++i
    #end

    puts team_radiant.inspect
    puts 'XXX'

    team_dire = Team.new(match['result']['dire_team_id'], match['result']['dire_name'])
    @teams.addTeam(team_dire)

    team_dire.addPlayer(Player.new match['result']['players'][5]['account_id'].to_i)
    team_dire.addPlayer(Player.new match['result']['players'][6]['account_id'].to_i)
    team_dire.addPlayer(Player.new match['result']['players'][7]['account_id'].to_i)
    team_dire.addPlayer(Player.new match['result']['players'][8]['account_id'].to_i)
    team_dire.addPlayer(Player.new match['result']['players'][9]['account_id'].to_i)

    #y = 0
    #while y < number_of_team_players
    #  team_dire.addPlayer(Player.new match['result']['players'][y+5]['account_id'].to_i)
    #  ++y
    #end
    puts team_dire.inspect

    puts "Teams: " + @teams.getTeamsIds.to_s

    puts "Team Radiant Players: "
    #puts match['result']['players'][0]['account_id']
    #puts match['result']['players'][1]['account_id']
    #puts match['result']['players'][2]['account_id']
    #puts match['result']['players'][3]['account_id']
    #puts match['result']['players'][4]['account_id']
    #
    #puts "Team Dire: #{team_dire_id}"
    puts "Team Dire Players: "
    #puts match['result']['players'][5]['account_id']
    #puts match['result']['players'][6]['account_id']
    #puts match['result']['players'][7]['account_id']
    #puts match['result']['players'][8]['account_id']
    #puts match['result']['players'][9]['account_id']





    #team_radiant = Team.new(match['result'][], )

    #hero
    #match['result']['picks_bans'].each { |pick_or_ban|
    #  word = ""
    #  if pick_or_ban['is_pick'] == true
    #    word = 'picked'
    #    ban = Hash.new
    #    ban['hero'] == pick_or_ban['hero_id']
    #    ban['order'] == pick_or_ban['order']
    #    ban['is_pick'] == false
    #  else
    #    pick = Hash.new
    #    pick['hero'] == pick_or_ban['hero_id']
    #    pick['order'] == pick_or_ban['order']
    #    pick['is_pick'] == true
    #    word = 'banned'
    #  end
    #  puts "Hero #{pick_or_ban['hero_id']} is #{word}."


      #match['result']['picks_bans'].each { |pick_or_ban|
      #  if pick_or_ban['is_pick'] == true
      #    ban = Hash.new
      #    ban['hero'] == pick_or_ban['hero_id']
      #    ban['order'] == pick_or_ban['order']
      #    !ban['is_pick']
      #  else
      #    pick = Hash.new
      #    pick['hero'] == pick_or_ban['hero_id']
      #    pick['order'] == pick_or_ban['order']
      #    pick['is_pick']
      #  end
      #}




      #heroes



  }


  puts "Lambada"

  @teams.getTeams.each { |team| puts team.inspect }

  #priradime hracum jmena, podle aktualniho nicku na Steamu
  @teams.getTeams.each do |team|
    team.getPlayers.each do |player|
      player.initializePlayerData
    end
  end

  #parsed_json = ActiveSupport::JSON.decode(contents)
  #
  #pickbans = parsed_json["result"]["picks_bans"]
  #
  #pickbans.each {
  #  |pb| puts pb["hero_id"]
  #}
  #
  #match = Match.new parsed_json["result"]
  #
  #puts pickbans
  #
  #league_matches = parsed_league['result']['matches']
  #@league_matches_id = Array.new
  #league_matches.each { |match| puts match['match_id']
  #  @league_matches_id << match['match_id']
  #}
  #leagueBansPicks = LeagueBansPicks.new @league_matches_id








  # mbid = MatchById.new 569673941

  #match = Nokogiri::JSON result
  #mamama = JSON.parse(open('http://api.steampowered.com/IDOTA2Match_570/GetMatchDetails/V001/?match_id=579138230&key=6D504458E48AEA1BA380F5D26001CE5B'))
  #puts result



end