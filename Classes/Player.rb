class Player
  @@last_player_checked

  def initialize(id)
    @id = id
  end

  def getPlayerId
    @id
  end

  def initializePlayerData
    #queryForPlayerName

  end

  private
  def queryForPlayerName
    sleep 2
    @@last_player_checked = @id
    #bohuzel nemuzeme pouzit, protoze @id neni uplne Steam ID ale jenom partial,bude se to muset este dozjistit.
    player_info = open('http://api.steampowered.com/ISteamUser/GetPlayerSummaries/v0002/?key=6D504458E48AEA1BA380F5D26001CE5B&steamids=' + @id.to_s )

    temp_file = File.open(player_info)
    contents = File.open(temp_file, 'rb') { |f| f.read }
    temp_file = File.open('files/players/' + @id.to_s, 'w') { |file| file.write(contents) }

    #contents = File.open(temp_file, 'rb') { |f| f.read }

    puts player_info.to_s
    #puts player_info

  end
end