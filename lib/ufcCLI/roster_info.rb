class UfcCLI::RosterInfo

    attr_accessor :name, :dob, :nickname, :weight_class, :location

    @@all = []

    def initialize(name = nil, dob = nil, nickname = nil, location = nil, weight_class = nil)
        @name = name
        @dob = dob
        @nickname = nickname
        @location = location
        @weight_class = weight_class
        @@all << self
    end

    def self.all
        @@all
    end


    def self.new_fighter(link)
        doc = Nokogiri::HTML(open("https://www.foxsports.com#{link}"))
        self.new(
            doc.css("span.wisbb_firstName").text + " " + doc.css("span.wisbb_lastName").text,
            doc.css(".wisbb_playerData td").children[1].text,
            doc.css(".wisbb_secondaryInfo span").children[0].text,
            doc.css(".wisbb_playerData tr").children[13].text.strip,
            doc.css(".wisbb_secondaryInfo span").children[2].text
        )
    end


    def self.all_names
        names = []
        @@all.each do |fighter|
            names << fighter.name
        end
        puts names
    end

    def self.guess_fighters_nickname
        names = []
        @@all.each {|fighter| names << fighter.name}
        random_fighter = names.sample
        puts ""
        puts "Guess the nickname of #{random_fighter}"

        input = gets.strip
        @@all.find do |f|
            if f.name == random_fighter
                if f.nickname.downcase.strip == "\"#{input.downcase}\""
                    puts "Correct!"
                else
                    puts "Incorrect"
                    puts "The answer was #{f.nickname}"
                end
            end
        end
        puts ""
        puts "Want to play again? y/n"
        choice = gets.strip
        if choice == "y"
            UfcCLI::RosterInfo.guess_fighters_nickname
        else
            puts ""
            puts "Do you want to return to the main menu? y/n"
            x = gets.strip
            if x == "y"
                UfcCLI::CLI.new.start
            else
                puts "Goodbye"
            end
        end

    end


        def self.fighter_info
            puts ""
            puts "Type name of fighter for info: "
            input = gets.strip
            @@all.detect do |fighter|
                if fighter.name.downcase == input.downcase
                    puts "\n"
                    puts "Date of Birth #{fighter.dob}"
                    puts "Nickname: #{fighter.nickname}"
                    puts "Location: #{fighter.location}"
                    puts "Weight Class: #{fighter.weight_class}"
                end
            end
            puts ""
            puts "Do you want to search for another fighters info? y/n"
            choice = gets.strip
            if choice == "y"
                UfcCLI::RosterInfo.fighter_info
            else
                puts ""
                puts "Do you want to return to the main menu? y/n"
                x = gets.strip
                if x == "y"
                    UfcCLI::CLI.new.start
                else
                    puts "Goodbye"
                end
            end
        end

end


