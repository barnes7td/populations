require_relative 'lib/setup'
require_relative 'lib/analytics'


class Population
  attr_accessor :analytics

  def initialize(analytics = Analytics.new())
    @analytics = analytics
    @choices = [nil,
                "Areas count",
                "Smallest Population (non 0)",
                "Largest Population",
                "How many zips in California",
                "Information for a given zip",
                "Exit"]
  end

  def menu
    system 'clear'
    puts "Population Menu"
    @choices.each_with_index do |choice, i|
      puts "#{i}. #{choice}" unless i == 0
    end
  end

  def run
    exit = false

    while !exit do
      # run the menu
      self.menu
      # grab the choice
      print "Choice: "
      choice = gets.strip.to_i
      # run their choice
      exit = run_analytics(choice)
      if exit
        puts "Exiting"
      else
        print "\nHit enter to continue "
        gets
      end
    end
  end

  def run_analytics(choice)
    if choice == 1
      @analytics.how_many
    elsif choice == 2
      @analytics.smallest_pop
    elsif choice == 3
      @analytics.largest_pop
    elsif choice == 4
      @analytics.california_zips
    elsif choice == 5
      print "Which zip? "
      zip = gets.strip.to_i
      @analytics.zip_info(zip)
    else
      return true
    end
    false
  end
end

p = Population.new
p.run
