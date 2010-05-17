module ShadyDB
  class Configuration
    attr_accessor :data_directory, :format

    def initialize
      @data_directory = '/data/db'
      @format = :json
    end
  end

  class << self
    attr_accessor :configuration
  end

  # Configure ShadyDB someplace sensible,
  # like config/initializers/shadydb.rb
  #
  # @example
  #   ShadyDB.configure do |config|
  #     config.data_directory     = Rails.root.join('db','shadydb')
  #     config.format             = :json
  #   end
  
  def self.configuration
    @configuration ||= Configuration.new
  end
  
  
  def self.configure
    self.configuration 
    yield(configuration)
  end
end