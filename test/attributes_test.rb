require 'helper'

class SampleDocument < ShadyDB::Document
  field :name
  field :role, :default => 'developer'
end

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
  
  context 'Defined fields' do
    should "allow defined fields which are always created" do
      document = SampleDocument.new
      assert document.attributes.key?('name')
      assert document.name.nil?
    end
    
    should "allow default values for defined fields" do
      document = SampleDocument.new
      assert document[:role] == 'developer'
    end
    
    should "be able to override default values" do
      document = SampleDocument.new :role => 'admin'
      assert document[:role] == 'admin'
    end
  end
  
end