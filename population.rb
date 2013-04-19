require_relative 'lib/analytics'
# require_relative 'lib/csv_reader'
# require_relative 'lib/area'

class Population
  # attr_accessor :analytics

  def initialize
    # setup
    @analytics = Analytics.new(@areas)
    @options   = @analytics.options
  end

  def menu
    system 'clear'
    puts "Population Menu"
    @options.each do |opt|
      puts "#{opt.index}. #{opt.description}"
    end
  end

  def run
    while true do
      # run the menu
      menu
      # grab the choice
      print "Choice: "
      choice = gets.strip.to_i
      # run their choice
      analysis = @analytics.run(choice)
      if analysis == :exit
        puts
        puts "Exiting"
        break
      else
        puts
        puts analysis
        print "\nHit enter to continue "
        gets
      end
    end
  end

end

p = Population.new
p.run
