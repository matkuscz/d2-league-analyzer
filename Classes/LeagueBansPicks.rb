require './Classes/Teams.rb'

class LeagueBansPicks
  def initialize matches_ids
    i = 0
    teams = Teams.new
    @matches = Array.new
    matches_ids.each do |match_id|



      @matches[i] = MatchById.new match_id,teams
      #Sleep is only needed when Steam is refusing to answer so quickly
      sleep 1
      i+=1

      #if i == 6
      #  break
      #end

    end




  end
end