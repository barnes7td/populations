class Analytics
  def initialize(areas = Setup.new().areas)
    @areas = areas
  end

  def how_many
    puts "There are #{@areas.length} areas"
  end

  def smallest_pop
    sorted = @areas.sort do |x, y| 
      x.estimated_population <=> y.estimated_population
    end
    smallest = sorted.drop_while { |i| i.estimated_population == 0 }.first
    puts "#{smallest.city}, #{smallest.state} has the smallest population of #{smallest.estimated_population}"
  end

  def largest_pop
    sorted = @areas.sort do |x, y| 
      x.estimated_population <=> y.estimated_population
    end
    largest = sorted.reverse.drop_while { |i| i.estimated_population == 0 }.first
    
    puts "#{largest.city}, #{largest.state} has the largest population of #{largest.estimated_population}"
  end

  def california_zips
    c = @areas.count { |a| a.state == "CA" }
    puts "There are #{c} zip code matches in California"
  end

  def zip_info(zip)
    zips = @areas.select { |a| a.zipcode == zip }
    unless zips.empty?
      puts ""
      zips.each { |z| puts z }
    else
      puts "Zip not found"
    end
  end
end
