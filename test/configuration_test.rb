require 'helper'

class ConfigurationTest < Test::Unit::TestCase
  
  context "Configuration" do
    should "have defaults" do
      config = ShadyDB::Configuration.new
      assert config.data_directory
      assert config.format
    end
    
    should "be accessible from ShadyDB.configuration" do
      assert ShadyDB.configuration.kind_of?(ShadyDB::Configuration)
    end
    
    should "be configurable" do
      original_config = ShadyDB.configuration
      ShadyDB.configuration = ShadyDB::Configuration.new
      ShadyDB.configure do |config|
        config.data_directory = '/shadydb'
        config.format = :xml
      end
      
      assert ShadyDB.configuration.data_directory == '/shadydb'
      assert ShadyDB.configuration.format == :xml
      
      ShadyDB.configuration = original_config
    end
  end
  
end