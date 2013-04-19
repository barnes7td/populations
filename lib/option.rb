class Option

  attr_reader :index, :description, :method

  def initialize(index, description, method)
    @index = index
    @description = description
    @method = method
  end

end
