require 'open-uri'
require 'net/https'
require 'nokogiri'
require 'json'
require 'active_support'
require './Classes/Match.rb'
require './Classes/LeagueBansPicks.rb'
require './Classes/AnalyzeMatchById.rb'
require './Classes/Downloader.rb'

class Main
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
  #@heroes = Arra

  @bans = Array.new
  teams = Teams.new


  @all_matches_of_league.each { |match|
    #puts match.to_s

    team_radiant = Team.new(match['result']['radiant_team_id'], match['result']['radiant_name'])
    puts team_radiant.inspect

    team_dire = Team.new(match['result']['dire_team_id'], match['result']['dire_name'])
    puts team_dire.inspect






    puts "Team Radiant Players: "
    puts match['result']['players'][0]['account_id']
    puts match['result']['players'][1]['account_id']
    puts match['result']['players'][2]['account_id']
    puts match['result']['players'][3]['account_id']
    puts match['result']['players'][4]['account_id']
    #
    #puts "Team Dire: #{team_dire_id}"
    puts "Team Dire Players: "
    puts match['result']['players'][5]['account_id']
    puts match['result']['players'][6]['account_id']
    puts match['result']['players'][7]['account_id']
    puts match['result']['players'][8]['account_id']
    puts match['result']['players'][9]['account_id']





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