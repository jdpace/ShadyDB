module ShadyDB
  
  class Document
    extend ActiveModel::Callbacks
    include ActiveModel::Validations
    include ShadyDB::Attributes
    include ShadyDB::Persistence
    
    before_save :validate
    
    def initialize(attribs = {})
      @new_record = true
      @destroyed = false
      
      self.attributes = {}
      self.attributes = attribs.stringify_keys if attribs.kind_of?(Hash)
    end
    
    def [](key)
      attributes[key.to_s]
    end
    
    def []=(key, value)
      attributes[key.to_s] = value
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