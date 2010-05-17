require 'helper'

class AttributesTest < Test::Unit::TestCase
  
  subject do
    @subject = ShadyDB::Document.new
  end
  
  context "Supporting hash-like interface for attributes" do
    should "allow reading attributes via []" do
      document = ShadyDB::Document.new :first_name => 'John', :last_name => 'Locke'
      assert document[:first_name] == 'John'
    end
    
    should "allow setting attribures via []=" do
      document = ShadyDB::Document.new
      document[:name] = 'Jack Shepard'
      assert document.attributes['name'] == 'Jack Shepard'
    end
  end
  
  context "Treating attribute keys like top level methods" do
    should "support top level methods for reading attributes" do
      document = ShadyDB::Document.new :first_name => 'John', :last_name => 'Locke'
      assert document.first_name == 'John'
    end
    
    should 'support top level methods for setting attributes' do
      document = ShadyDB::Document.new :name => 'Hugo'
      document.name = 'Jack Shepard'
      assert document.attributes['name'] == 'Jack Shepard'
    end
  end
  
end