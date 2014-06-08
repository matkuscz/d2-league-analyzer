class Team
  def initialize id,name
    @team_id = id.to_i
    @team_name = name.to_s
    @players = Set.new
    @matches = Array.new
  end

  def getTeamId
    @team_id
  end

  def getTeamName
    @team_name
  end

  def addPlayer(player)
    puts "Pridavam playera"
    addOnlyUnique player

  end

  def getPlayers
    @players
  end
#  @team_id
#  @team_name
#  @victories
#  @defeats
#  @picks
#  @bans

  private
  def addOnlyUnique player
   known_player = false
   player_id = player.getPlayerId
   puts player_id

   @players.each { |_player|
     puts "Known player id " + _player.getPlayerId.to_s
     if _player.getPlayerId.to_i == player_id.to_i
       known_player = true
       puts "We have a match"
       puts "Player not added"
     end
   }

   if known_player == false
     puts "Same id not found"
     puts "Hrac pridan"
     @players.add player
     return true
   end
   return false
  end
end