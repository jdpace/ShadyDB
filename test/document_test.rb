require 'helper'

class DocumentTest < Test::Unit::TestCase
  include ActiveModel::Lint::Tests
  
  def setup
    @model = ShadyDB::Document.new
  end
end
