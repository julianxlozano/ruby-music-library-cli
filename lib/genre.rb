class Genre
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
        genre_songs= Song.all.select{|song|song.genre == self}
        genre_songs.uniq 
    end

    def artists
        # binding.pry 
       artists_collection=  self.songs.collect{|song|song.artist}
       artists_collection.uniq 
     end
   
end