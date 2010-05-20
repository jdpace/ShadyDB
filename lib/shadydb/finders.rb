module ShadyDB
  
  module Finders
    
    def self.included(base)
      base.class_eval do
        extend ClassMethods
      end
    end
    
    module ClassMethods
      def find(id)
        return false unless self.exists?(id)
        
        document = self.new :id => id
        document.send(:restore!)
        document.instance_variable_set('@new_record', false)
        document
      end
      
      def exists?(id)
        document = self.new :id => id
        File.exist?(document.path)
      end
    end
  end
  
end