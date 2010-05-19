module ShadyDB
  
  class Document
    extend ActiveModel::Callbacks
    include ActiveModel::Validations
    include ShadyDB::Attributes
    include ShadyDB::Finders
    include ShadyDB::Persistence
    
    before_save :validate
    
    def initialize(attribs = {})
      @new_record = true
      @destroyed = false
      
      self.attributes = attribs.stringify_keys
      self.attributes.reverse_merge!(self.class.fields)
    end
    
    def to_model
      self
    end
    
    def to_param
      id
    end
    
    def to_key
      persisted? ? [id] : nil
    end
    
    protected
    
      def validate
        valid?
      end
    
  end
  
end