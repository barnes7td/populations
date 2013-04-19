require_relative './option'
require_relative './csv_reader'
require_relative './area'

class Analytics
  attr_reader :options

  def initialize(areas)
    @areas = areas
    @options = []
    set_options
  end

  def set_options
    @options << Option.new(1, 'Areas count', :how_many)
    @options << Option.new(2, 'Smallest Population (non 0)', :smallest_pop)
    @options << Option.new(3, 'Largest Population', :largest_pop)
    @options << Option.new(4, 'How many zips in California', :california_zips)
    @options << Option.new(5, 'Information for a given zip', :zip_info)
    @options << Option.new(6, 'Exit', :exit)
  end


  def run(choice)
    option = @options.select { |opt| opt.index == choice  }.first
    if option == nil
      return"Invalid choice"
    elsif option.method == :exit
      return :exit
    end
    setup
    self.send option.method
  end

  def setup
    @areas ||= read_file
  end

  def read_file(csv = CSVReader.new("./zipcode-db.csv"))
    areas = []
    count = 0

    print "\nreading file ."
    csv.read do |item|
      areas << Area.new(item)
      count += 1
      print "." if (count % 3000) == 0
    end
    print "\n"
    areas
  end

  def how_many
    "There are #{@areas.length} areas"
  end

  def smallest_pop
    sorted = @areas.sort do |x, y|
      x.estimated_population <=> y.estimated_population
    end
    smallest = sorted.drop_while { |i| i.estimated_population == 0 }.first
    "#{smallest.city}, #{smallest.state} has the smallest population of #{smallest.estimated_population}"
  end

  def largest_pop
    sorted = @areas.sort do |x, y|
      x.estimated_population <=> y.estimated_population
    end
    largest = sorted.reverse.drop_while { |i| i.estimated_population == 0 }.first

    "#{largest.city}, #{largest.state} has the largest population of #{largest.estimated_population}"
  end

  def california_zips
    c = @areas.count { |a| a.state == 'CA' }
    "There are #{c} zip code matches in California"
  end

  def zip_info
    print 'Which zip? '
    zip = gets.strip.to_i

    zips = @areas.select { |a| a.zipcode == zip }
    if zips.empty?
      'Zip not found'
    else
      # puts
      zips.each { |z| z }
    end
  end

end
