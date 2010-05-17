require 'helper'

class FindersTest < Test::Unit::TestCase
  
  context "Finding a document by its ID" do
    should "load the document exactly as it was saved" do
      original = ShadyDB::Document.create :name => 'Sawyer'
      found = ShadyDB::Document.find original.id
      
      assert found.id == original.id
      assert found.name == original.name
      assert found.attributes == original.attributes
    end
  end
  
end