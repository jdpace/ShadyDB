require 'rubygems'
require 'test/unit'
require 'shoulda'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'shadydb'

class Test::Unit::TestCase
  
  def teardown
    purge_documents
  end
  
  def purge_documents
    FileUtils.rm_rf(File.join(File.expand_path(File.dirname(__FILE__)), 'db'))
  end
  
end

ShadyDB.configure do |config|
  config.data_directory = File.join(File.expand_path(File.dirname(__FILE__)), 'db')
end