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
  
  context "Checking whether or not a Document exists" do
    should "return true if a document is persited" do
      document = ShadyDB::Document.create :name => 'Sawyer'
      assert document.persisted?
      assert ShadyDB::Document.exists?(document.id)
    end
    
    should "return false if a document is not persited" do
      document = ShadyDB::Document.new :id => 'fake-id', :name => 'Sawyer'
      assert !document.persisted?
      assert !ShadyDB::Document.exists?(document.id)
    end
  end
  
end