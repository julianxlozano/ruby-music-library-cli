class MusicLibraryController

    def initialize(path="./db/mp3s")
        @path=path
       new_import= MusicImporter.new(@path)
       new_import.import 
    end 

    def call
        puts "Welcome to your music library!"
        puts "To list all of your songs, enter 'list songs'."
        puts "To list all of the artists in your library, enter 'list artists'."
        puts "To list all of the genres in your library, enter 'list genres'."
        puts "To list all of the songs by a particular artist, enter 'list artist'."
        puts "To list all of the songs of a particular genre, enter 'list genre'."
        puts "To play a song, enter 'play song'."
        puts "To quit, type 'exit'."
        puts "What would you like to do?"

        input = gets.chomp

        case 
        when input == "list songs" then list_songs
        when input == "list artists" then list_artists
        when input == "list genres" then list_genres
        when input == "list artist" then list_songs_by_artist
        when input == "list genre" then list_songs_by_genre
        when input == "play song" then play_song
        end

        unless input == 'exit'
            call 
        end
    end

    def list_songs
        sorted_songs=  Song.all.sort_by{|song|song.name}
        sorted_songs.each.with_index(1) do |song,index|
            puts "#{index}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
        end 
    end

    def list_artists
        sorted_songs=  Artist.all.sort_by{|artist|artist.name}
        sorted_songs.each.with_index(1) do |artist,index|
            puts "#{index}. #{artist.name}"
        end 
    end

    def list_genres
        sorted_songs=  Genre.all.sort_by{|genre|genre.name}
        sorted_songs.each.with_index(1) do |genre,index|
            puts "#{index}. #{genre.name}"
        end 
    end

    def list_songs_by_artist
        puts "Please enter the name of an artist:"
        input = gets.chomp#.split.map(&:capitalize).join(' ') 

     #   binding.pry 

       artist_obj= Artist.find_by_name(input)
       unless artist_obj == nil 
       artist_songs_list = artist_obj.songs 

        sorted_songs=  artist_songs_list.sort_by{|song|song.name}
        sorted_songs.each.with_index(1) do |song,index|
            puts "#{index}. #{song.name} - #{song.genre.name}"
        end
        end
        
    end

    def list_songs_by_genre
        puts "Please enter the name of a genre:"
        input = gets.chomp 
        genre_obj = Genre.find_by_name(input)
        unless genre_obj == nil 
        genre_songs_list = genre_obj.songs 
        sorted_songs = genre_songs_list.sort_by{|song|song.name}
        sorted_songs.each.with_index(1) do |song,index|
            puts "#{index}. #{song.artist.name} - #{song.name}"
        end
        end 

    end

    def play_song
       puts "Which song number would you like to play?"
       input = gets.chomp.to_i - 1
       if input.between?(1,Song.all.size)
       sorted_songs=  Song.all.sort_by{|song|song.name}
       selected_song = sorted_songs[input]
       unless selected_song == nil 
       puts "Playing #{selected_song.name} by #{selected_song.artist.name}"
       end
    end
    end

    

    



end