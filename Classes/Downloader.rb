class Downloader
  def initialize
    OpenURI::Buffer.send :remove_const, 'StringMax'
    OpenURI::Buffer.const_set 'StringMax', 0
  end

  def download_list_of_league_matches league_id
    #cz/sk liga id: 1002

    @league_id = league_id
    puts 'Trying to download list of all matches from league id: ' + @league_id.to_s
    if @league_id == 579138230 then puts 'CZ/SK Dota 2 League' end

      list = open('http://api.steampowered.com/IDOTA2Match_570/GetMatchHistory/V001/?league_id=' + @league_id.to_s + '&key=6D504458E48AEA1BA380F5D26001CE5B')
      puts 'We have answer from STEAM ! Nice :) '
      puts 'Size of answer: ' + list.size.to_s

    temp_file = File.open(list)
    contents = File.open(temp_file, 'rb') { |f| f.read }
    league_matches_file = File.open('./files/list_of_league_matches.json', 'w') { |file| file.write(contents) }
    lmf = File.open('./files/list_of_league_matches.json', 'rb') {  |f| f.read  }
    puts 'List of league matches successfully saved to file: ./files/list_of_league_matches.json'


    puts 'All files closed'
    @parsed_league = ActiveSupport::JSON.decode(lmf)
    puts 'Info about league parsed'
    @parsed_league
  end




  def download_each_league_match(parsed_league)
    @parsed_league = parsed_league
    puts 'Trying to download all league matches'
    league_matches = @parsed_league['result']['matches']
    league_matches_id = Array.new
    league_matches.each { |match| puts match['match_id']
      league_matches_id << match['match_id']
    }

    matches = Array.new
    i = 0
    league_matches_id.each do |match_id|
      puts 'Downloading match ' + (i+1).to_s + '/' + league_matches_id.size.to_s
      match_id_string = match_id.to_s
      matches[i] = open('http://api.steampowered.com/IDOTA2Match_570/GetMatchDetails/V001/?match_id=' + match_id_string + '&key=6D504458E48AEA1BA380F5D26001CE5B')

      temp_file = File.open(matches[i])
      contents = File.open(temp_file, 'rb') { |f| f.read }

      match_file = File.open('./files/matches/'+ @league_id.to_s + '/' + match_id_string, 'w') { |file| file.write contents }
      #Sleep is only needed when Steam is refusing to answer quickly
      sleep 2
      i+=1
      puts '---Match file saved'
    end
  end

  def download_match_by_id id

  end
end