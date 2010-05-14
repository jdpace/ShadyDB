module ShadyDB
  
  module Extensions
    
    module String
      
      module Helpers
        def reader
          writer? ? gsub("=", "") : self
        end

        def writer?
          include?("=")
        end
      end
      
    end
    
  end
  
end