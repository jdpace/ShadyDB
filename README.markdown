# ShadyDB

ShadyDB is a document persistence layer that speaks ActiveModel.
Like it's name says it is _shady_ and is **merely impersonating a database**.
Its saves records/documents to the file system as XML or JSON files.

In general you should use a traditional database for 99.999% of cases. Real databases
handle this type of thing way better. If you think ShadyDB is really the way to
go, think again because you're probably mistaken. ShadyDB is just a ActiveRecord like 
wrapper for the file system and lacks traditional data integrity schemes.

ShadyDB is built on top of ActiveModel and as a result is a great learning tool for
understanding the modularity and power that ActiveModel brings. I highly encourage
anyone to spend the time to write their own ORM.

## Usage

    class User < ShadyDB::Document
    end
    
    u = User.new(:name => 'Marshall Mathers')
    u.new_record? # true
    u.save # true
    u.new_record? # false
    
    u.name # 'Marshall Mathers'
    u[:name] # 'Marshall Mathers'
    
    u = User.create(:name => 'Eminem')
    u.new_record? # false
    
    
## Configuration

    ShadyDB.configure do |config|
      config.data_directory = Rails.root.join('db','shadydb')
      config.format         = :xml
    end
    
## TODO

* Add an optional encryption layer
* Add support for collection finders
* Add support for conditional finders
* Add simple indexing

## Note on Patches/Pull Requests
 
* Fork the project.
* Make your feature addition or bug fix.
* Add tests for it. This is important so I don't break it in a
  future version unintentionally.
* Commit, do not mess with rakefile, version, or history.
  (if you want to have your own version, that is fine but bump version in a commit by itself I can ignore when I pull)
* Send me a pull request. Bonus points for topic branches.

## Copyright

Copyright (c) 2010 Jared Pace. See LICENSE for details.
