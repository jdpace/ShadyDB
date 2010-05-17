# ShadyDB

ShadyDB is a document persistence layer that speaks ActiveModel.
Like it's name says it is _shady_ and **should be avoided** at all costs!
Its saves records/documents to the file system as XML or JSON files.
There is a built in encryption layer so that files are stored in a secure
manner.

Why are you still here!? I'm not joking. Do not use this library. Real databases
handle this type of thing way better. If you think ShadyDB is really the way to
go, think again because you're probably WRONG.

## Usage

    class User < ShadyDB::Document
    end
    
    u = User.new(:name => 'Jared Pace')
    u.new_record? -> true
    u.save # true
    u.new_record? -> false
    
    u.name -> 'Jared Pace'
    u[:name] -> 'Jared Pace'
    
    u = User.create(:name => 'Jared Pace')
    u.new_record? -> false
    
    
## Configuration

    ShadyDB.configure do |config|
      config.data_directory = Rails.root.join('db','shadydb')
      config.format         = :xml
    end

## Note on Patches/Pull Requests
 
* Fork the project.
* Make your feature addition or bug fix.
* Add tests for it. This is important so I don't break it in a
  future version unintentionally.
* Commit, do not mess with rakefile, version, or history.
  (if you want to have your own version, that is fine but bump version in a commit by itself I can ignore when I pull)
* Send me a pull request. Bonus points for topic branches.

## Copyright

Copyright (c) 2010 jdpace. See LICENSE for details.
