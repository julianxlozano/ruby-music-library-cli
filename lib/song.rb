class Song
    attr_accessor :name
    attr_reader :artist, :genre  
    @@all=[]
    def initialize(name,artist=nil,genre=nil)
        @name = name
        unless artist == nil 
        self.artist = artist
        end 
        unless genre == nil
        self.genre = genre
        end 
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

    def artist=(artist)
        @artist=artist 
        @artist.add_song(self) 
    end

    
    def genre=(genre)
        @genre=genre 
    end

    def self.find_by_name(name)
     self.all.detect{|song| song.name == name }  
    end

    def self.find_or_create_by_name(name)   
      find_by_name(name) ||self.create(name)  
    end

    def self.new_from_filename(filename)
        #binding.pry 
         song_title= filename.split(" - ")[1]
         artist_name= filename.split(" - ")[0]
         genre_name = filename.gsub(/\s+/, "").split(/[.-]/)[2]
         if genre_name == "hip"
            genre_name = "hip-hop"
         end
         if genre_name == "dreampop"
            genre_name = "dream pop"
         end
        # binding.pry
         new_song= find_or_create_by_name(song_title)
         new_song.artist = Artist.find_or_create_by_name(artist_name)
         new_song.genre = Genre.find_or_create_by_name(genre_name)
         new_song
    end

    def self.create_from_filename(filename)
       new_instance = self.new_from_filename(filename)
    end





  
   
end