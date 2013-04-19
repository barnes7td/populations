class Option

  attr_reader :index, :description, :report

  def initialize(index, description, report)
    @index = index
    @description = description
    @report = report
  end

end
