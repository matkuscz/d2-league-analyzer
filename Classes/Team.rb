class Team
  def initialize id,name
    @team_id = id.to_s
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
    @players << player
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
end