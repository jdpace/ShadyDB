require 'helper'

class PersistenceTest < Test::Unit::TestCase
  
  context "Creating a new document" do
    should "Save and return a document" do
      @document = ShadyDB::Document.create :name => 'Dharma Initiative'
      assert @document.persisted?
      assert File.exist?(@document.path)
    end
  end
  
  context "Saving a new document" do
    setup do
      @document = ShadyDB::Document.new :name => 'Dharma Initiative'
    end
    
    should "save the document to the file system" do
      assert @document.save
      assert File.exist?(@document.path)
    end
  end
  
  context "Saving an existing document" do
    setup do
      @document = ShadyDB::Document.create :name => 'Dharma Initiative'
      @before = File.new(@document.path).atime
    end
    
    should "update the document on the file system" do
      assert @document.save
      assert File.new(@document.path).atime >= @before
    end
  end
  
  context "Updating an existing document" do
    setup do
      @document = ShadyDB::Document.create :name => 'Dharma Initiative'
      @before = File.new(@document.path).atime
    end
    
    should "update the attributes" do
      assert @document.update_attributes :location => 'The Island'
      assert @document.location == 'The Island'
    end
    
    should "update the document on the file system" do
      assert @document.update_attributes :location => 'The Island'
      assert File.new(@document.path).atime >= @before
    end
  end
  
  context "Destroying a document" do
    setup do
      @document = ShadyDB::Document.create :name => 'Dharma Initiative'
    end
    
    should "remove the document from the file system" do
      assert @document.destroy
      assert !File.exist?(@document.path)
    end
  end
  
end