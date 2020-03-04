# First Name: soc.css("span.wisbb_firstName").text
# Last Name: soc.css("span.wisbb_lastName").text
# Nickname: soc.css(".wisbb_secondaryInfo span").children[0].text
# D.O.B: doc.css(".wisbb_playerData tr").children[3].text
# Weight Class: soc.css(".wisbb_secondaryInfo span").children[2].text
# Location: soc.css(".wisbb_playerData tr").children[13].text.strip
# Reach: soc.css(".wisbb_playerData tr").children[18].text
# Stance: soc.css(".wisbb_playerData tr").children[23].text

class UfcCLI::RosterInfo

    attr_accessor :name, :dob, :nickname, :weight_class, :location, :reach, :stance

    @@all = []

# dob = nil, nickname = nil

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

    def dc
        doc = Nokogiri::HTML(open("https://www.foxsports.com/ufc/daniel-cormier-fighter-stats"))
        roc = Nokogiri::HTML(open("https://www.foxsports.com/ufc/francis-ngannou-fighter-stats"))
        binding.pry
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
        puts "Guess the nickname of #{random_fighter}"

        input = gets.strip
        @@all.find do |f|
            if f.name == random_fighter
                if f.nickname.downcase.strip == input.downcase
                    puts "Correct!"
                else
                    puts "Incorrect"
                end
            end
        end
        puts "Want to play again? y/n"
        choice = gets.strip
        if choice == "y"
            UfcCLI::RosterInfo.guess_fighters_nickname
        else
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
            puts "Type name of fighter for info: "
            input = gets.strip
            @@all.detect do |fighter|
                if fighter.name.downcase == input.downcase
                    puts "Date of Birth #{fighter.dob}"
                    puts "Nickname: #{fighter.nickname}"
                    puts "Location: #{fighter.location}"
                    puts "Weight Class: #{fighter.weight_class}"
                end
            end
            puts "Do you want to search for another fighters info? y/n"
            choice = gets.strip
            if choice == "y"
                UfcCLI::RosterInfo.fighter_info
            else
                puts "Do you want to return to the main menu? y/n"
                x = gets.strip
                if x == "y"
                    UfcCLI::CLI.new.start
                else
                    puts "Goodbye"
                end
            end
        end


    # def self.guess_fighters_nickname
    #     puts "Input fighter name to get their nickname? "
    #     input = gets.strip
    #     @@all.find do |fighter|
    #         if fighter.name.downcase == input.downcase
    #             puts fighter.nickname
    #         end
    #     end
    #     puts "Do you want to play again? y/n"
    #     again = gets.strip
    #     if again == "y"
    #         self.get_fighters_nickname
    #     else
    #         puts "Goodbye"
    #     end
    # end


    # custom instance methods if needed

end


