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
      begin
        File.delete("/Users/jdpace/Desktop/db/#{@id}")
      rescue
        false
      end
    end
    
    def self.find(id)
      return false unless File.exist?("/Users/jdpace/Desktop/db/#{id}")
      storage = File.read("/Users/jdpace/Desktop/db/#{id}")
      attribs = storage.to_hash # TODO
      
      document = new(attribs)
      document.instance_variable_set('@new_record', false)
      document
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
    
    protected
    
      def create_or_update
        persisted? ? update : create
      end
      
      def create        
        _run_create_callbacks do
          new_id = generate_id
          
          File.open("/Users/jdpace/Desktop/db/#{new_id}",'w') do |storage|
            storage << self.to_xml
          end
          @id = new_id
          @new_record = false
          
          true
        end
      end
      
      def update
        _run_update_callbacks do
          File.open("/Users/jdpace/Desktop/db/#{@id}",'w') do |storage|
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