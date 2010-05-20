module ShadyDB
  
  module Persistence
    extend ActiveSupport::Concern
    include ActiveModel::Serializers::JSON
    include ActiveModel::Serializers::Xml
    
    def self.included(base)
      base.class_eval do
        define_model_callbacks :save, :create, :update, :destroy, :persist, :restore
        
        before_persist :_set_raw
        before_restore :_get_raw
        before_create :_ensure_data_directory_exists
        
        extend ClassMethods
      end
    end
    
    module ClassMethods
      def create(attribs = {})
        document = new(attribs)
        document.save && document
      end
      
      def data_directory
        File.join(ShadyDB.configuration.data_directory, self.model_name.plural)
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
      File.join(self.class.data_directory, id)
    end
    
    protected
    
      def _ensure_data_directory_exists
        self.class.data_directory.split('/').inject do |base, dir_name|
          dir = File.join(base, dir_name)
          Dir.mkdir(dir) unless File.exist?(dir)
          dir
        end
      end
    
      def create_or_update
        persisted? ? update : create
      end
      
      def create        
        _run_create_callbacks do
          generate_id
          persist!
          @new_record = false
          
          true
        end
      end
      
      def update
        _run_update_callbacks do
          persist!          
          true
        end
      end
      
      def persist!
        _run_persist_callbacks do
          File.open(path,'w') do |storage|
            storage << @raw
          end
        end
      end
      
      def restore!
        _run_restore_callbacks do
          send(:"from_#{ShadyDB.configuration.format}" ,@raw)
        end
      end
      
      def _set_raw
        @raw = self.send(:"to_#{ShadyDB.configuration.format}")
      end
      
      def _get_raw
        @raw = File.read(path)
      end
      
      def generate_id
        while(id.nil? || self.class.exists?(id)) do
          self.id = ActiveSupport::SecureRandom.hex()
        end
      end
      
  end
  
end