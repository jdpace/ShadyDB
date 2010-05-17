module ShadyDB
  
  module Attributes
    
    def self.included(base)
      base.class_eval do
        attr_accessor :id, :attributes
      end
    end
    
    def [](key)
      attributes[key.to_s]
    end
    
    def []=(key, value)
      attributes[key.to_s] = value
    end
    
    # Used for allowing accessor methods for dynamic attributes.
    # Pulled from Mongoid
    def method_missing(name, *args)
      attr = name.to_s
      return super unless @attributes.has_key?(attr.reader)
      if attr.writer?
        # "args.size > 1" allows to simulate 1.8 behavior of "*args"
        @attributes[attr.reader] = (args.size > 1) ? args : args.first
      else
        @attributes[attr.reader]
      end
    end
    
  end
  
end