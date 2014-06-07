require './Classes/Team.rb'

class Teams
  @team_to_add = false
  def initialize
    @teams = Array.new
    @teams.push Team.new(1,'Test')
  end

  def addTeam team
    #@team_to_add = false
    puts 'Trying to add team ' + team.getTeamName
    if team != nil
      puts 'Team is not nil'

      @teams.each { |t|
        puts t.getTeamId
        puts team.getTeamId
        if t.getTeamId == team.getTeamId
          puts 'Pici, team already known: ' + team.getTeamName
          @team_to_add = false
        else
          @team_to_add = true
        end
      }


      #if (@teams.include? team == true)
      #  puts 'team already known'
      #else
      #@teams.push team
      #end



      #@teams.each { |t| if t.getTeamId == team.getTeamId
      #                    puts 'Team already known'
      #                  else
      #                    @teams.push team
      #                    puts 'Team added'
      #                  end
      #}


    end

    if @team_to_add
      puts 'Team added: ' + team.getTeamName
      @teams.push team
      @team_to_add = false
    end

    puts @teams.inspect
    puts '++++++++++++++++++++++++++'
  end





  def getTeamsIds
    @teams.keys
  end

  def parseTeams


  end

end