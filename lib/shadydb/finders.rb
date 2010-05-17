module ShadyDB
  
  module Finders
    
    def self.included(base)
      base.class_eval do
        extend ClassMethods
      end
    end
    
    module ClassMethods
      def find(id)
        document = self.new
        document.instance_variable_set('@id', id)
        
        return false unless File.exist?(document.path)
        storage = File.read(document.path)
        
        document.send(:restore!, storage)
        document.instance_variable_set('@new_record', false)
        document
      end
    end
    
  end
  
end