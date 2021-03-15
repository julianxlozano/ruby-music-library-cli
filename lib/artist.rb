require'pry'



class Artist
    extend Concerns::Findable
    attr_accessor :name 
    @@all=[]
    def initialize(name)
        @name=name
       save 
    end

    def save 
        @@all << self 
    end 

    def self.all
        @@all.uniq 
    end

    def self.destroy_all
        @@all.clear
    end 

    def self.create(name)
       new_self= self.new(name)
        new_self.save 
        new_self 
    end

    def songs
       artist_songs= Song.all.select{|song|song.artist == self}
       artist_songs.uniq 
    end

    def add_song(song)
        unless song.artist != nil 
            song.artist=self 
        end  
    end

    def genres 
       # binding.pry 
      genres_collection=  self.songs.collect{|song|song.genre}
      genres_collection.uniq
    end

    


end
