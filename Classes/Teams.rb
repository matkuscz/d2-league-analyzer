require './Classes/Team.rb'

class Teams
  def initialize
    @teams = Set.new
    test_team = Team.new(1,'Test')


  end

  def addTeam team
    #puts "Pridavam team"
    addOnlyUnique team
  end

  def getTeamsIds
    ids = Array.new
    @teams.each { |t| ids.push(t.getTeamId) }
    ids
  end

  def parseTeams

  end

  def getTeams
    @teams
  end

  private
  def addOnlyUnique team
    known_team = false
    team_id = team.getTeamId
    #puts team_id

    @teams.each { |_team|
      #puts "Known team id " + _team.getTeamId.to_s
      if _team.getTeamId == team_id.to_i
        known_team = true
        #puts "We have a match"
        #puts "Team not added"
      end
    }

    if known_team == false
      #puts "Same id not found"
      #puts "Adding team"
      @teams.add team
      return true
    end
    return false
  end
end