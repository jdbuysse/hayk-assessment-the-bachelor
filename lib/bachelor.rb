require 'pry'


def get_first_name_of_season_winner(data, season)
  t = data.each_key.find {|seas| seas == season}
  w = data[t].each.find { |status| status = "Winner"}
  w["name"].split(' ').first
end

def get_contestant_name(data, occupation)
  
  # I tried doing this with find but I couldn't figure it out, since the outer loop of find always returns the matching season rather than contestant or whatevers
  #res = data.each_with_index.find { |season, index| data[season][index]["occupation"] == occupation }
  # data.each_with_index.find do |(key, value), index| # should I remove or keep find from this line?
  #   #binding.pry
  #   return data[key].find { |contestant| contestant["occupation"] == occupation}
  # end

  # one way to do it
  # res = []
  # data.each_key do |key|
  #   data[key].each do |contestant|
  #     if contestant["occupation"] == occupation
  #       res.push(contestant["name"])
  #     end
  #   end 
  # end  
  # res.join('')

  # I think this is DRYer? but there's gotta be a cleaner way
  season = data.each_key.find do |key|
    data[key].each.find do |contestant|
      contestant["occupation"] == occupation
    end
  end
  data[season].find { |i| i["occupation"] == occupation }["name"]



end

def count_contestants_by_hometown(data, hometown)
  # quick and dirty solution
  count = 0
  data.each_key do |season|
    data[season].each do |contestant|
      if contestant["hometown"] == hometown
        count += 1
      end
    end
  end
  count

  # you could use reduce to accumulate sum? I want to do reduce but it doesn't persist through multiple loops
  # data.each_key do |season|
  #   data[season].reduce(0) do |sum, contestant|
  #     binding.pry
  #     if contestant["hometown"] == hometown
  #       sum + 1
  #     end
  #   end
  # end
  # sum
end

def get_occupation(data, hometown)
  # quick and dirty version
  season = data.each_key.find do |key|
    data[key].each.find do |contestant|
      contestant["hometown"] == hometown
    end
  end
  data[season].find { |i| i["hometown"] == hometown }["occupation"]

end

def get_average_age_for_season(data, season)
  total = data[season].reduce(0) { |sum, contestant| sum + contestant["age"].to_i}
  (total / data[season].length.to_f).round
end
