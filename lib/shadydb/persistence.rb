module ShadyDB
  
  module Persistence
    extend ActiveSupport::Concern
    include ActiveModel::Serializers::JSON
    include ActiveModel::Serializers::Xml
    
    def self.included(base)
      base.class_eval do
        define_model_callbacks :save, :create, :update, :destroy
        
        extend ClassMethods
      end
    end
    
    module ClassMethods
      def create(attribs = {})
        document = new(attribs)
        document.save && document
      end
    end
    
    def save
      _run_save_callbacks do
        create_or_update
      end
    end
    
    def update_attributes(attribs)
      @attributes.merge!(attribs.stringify_keys)
      save
    end
    
    def destroy
      return false unless persisted?
      begin
        File.delete(path)
        @destroyed = true
      rescue
        false
      end
    end
    
    def persisted?
      !(new_record? || destroyed?)
    end
    
    def new_record?
      @new_record
    end
    
    def destroyed?
      @destroyed
    end
    
    def path
      "/Users/jdpace/Desktop/db/#{@id}"
    end
    
    protected
    
      def create_or_update
        persisted? ? update : create
      end
      
      def create        
        _run_create_callbacks do
          @id = generate_id
          
          File.open(path,'w') do |storage|
            storage << self.to_xml
          end
          @new_record = false
          
          true
        end
      end
      
      def update
        _run_update_callbacks do
          File.open(path,'w') do |storage|
            storage << self.to_xml
          end
          
          true
        end
      end
      
      # TODO: should check if ID is already taken
      def generate_id
        ActiveSupport::SecureRandom.hex()
      end
      
  end
  
end