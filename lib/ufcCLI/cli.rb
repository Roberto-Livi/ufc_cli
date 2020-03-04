require 'pry'
class UfcCLI::CLI

    # start should greet user, maybe give desc
    # get data from scraper/api file
    # create new custom objs
    # all inside start method

    # Name: doc.css("span.wisbb_leaderName").text
    # Name: doc.css("span.wisbb_leaderName")[28].text
    # Weight Class: doc.css("span.wisbb_leaderTitle").text
    # Record: doc.css("span.wisbb_leaderValue").text
    # Rank: doc.css("span.wisbb_leaderRank").text

    # Profile Url:  # name.first.css("a").first.attributes["href"].value
        # doc.css("span.wisbb_leaderName").css("a")[1].attributes["href"].value

    # # Weight Class
    # weight_class = []
    # doc.css("span.wisbb_leaderTitle").each {|weight| weight_class << weight.text}


    # @@all_fighters = []
    @@o_h = 0
    @@o_pfp = 0
    @@o_lh = 0
    @@o_mw = 0
    @@o_ww = 0


    def start

            puts "Welcome UFC fans!"
            puts "GETTING DATA FROM API ... PLEASE WAIT"
            doc = Nokogiri::HTML(open("https://www.foxsports.com/ufc/rankings"))
            puts "Which division do you want to see?\n1) Men\n2) Women"
            input = gets.chomp()
        if input  == "1"

            puts "Which weight class would you like to see?"
            puts "1) Pound for Pound\n2) Heavyweight\n3) Light Heavyweight\n4) Middleweight\n5) Welterweight"
            choice = gets.chomp()

            case(choice)

            when '1'
                if @@o_pfp == 0
                    scrape_pfp
                    pound_for_pound
                else
                    pound_for_pound
                end
            when '2'
                if @@o_h == 0
                    scrape_hw
                    heavyweight
                else
                    heavyweight
                end
            when '3'
                if @@o_lh == 0
                    scrape_lh
                    light_heavyweight
                else
                    light_heavyweight
                end
            when '4'
                if @@o_mw == 0
                    scrape_mw
                    middleweight
                else
                    middleweight
                end
            when '5'
                if @@o_ww == 0
                    scrape_ww
                    welterweight
                else
                    welterweight
                end
            else
                puts "Not an option. Please try again.."
                sleep 1
                start
            end

        elsif input == "2"

            puts "Which weight class would you like to see?"
            puts "1) Bantamweight\n2) Strawweight"
            choice_2 = gets.chomp()
            case(choice_2)
            when '1'
                womens_bantamweight
            when '2'
                womens_strawweight
            else
                puts "Not an option"
            end
        else
            puts "Not an option"
        end

    end

    def next_step

        puts "\n1) Check out another ranking\n2) Fighter info from the rankings of fighters that you have checked out\n3) Play a game\n4) exit"
        input = gets.strip

        case(input)
        when '1'
            start
        when '2'
            UfcCLI::RosterInfo.fighter_info
        when '3'
            UfcCLI::RosterInfo.guess_fighters_nickname
        when '4'
            puts "Goodbye"
        else
            puts "Not an option. Please try again.."
            sleep 1
            next_step
        end

    end

    def fighters
        doc = Nokogiri::HTML(open("https://www.foxsports.com/ufc/rankings"))

        doc.css("span.wisbb_leaderName").each {|fighter| @@all_fighters << fighter.text}
        ufc_roster = []
        @@all_fighters.each {|name| ufc_roster << name unless ufc_roster.include?(name)}
        puts "UFC Roster: #{ufc_roster}"
    end

    def scrape_hw
        doc = Nokogiri::HTML(open("https://www.foxsports.com/ufc/rankings"))
        UfcCLI::Scraper.new.scrape_heavyweights
    end

    def heavyweight

        doc = Nokogiri::HTML(open("https://www.foxsports.com/ufc/rankings"))
        # UFcCLI::Scraper.new.scrape_fighters_url
        # Fighter names
        fighter_names = []
        doc.css("span.wisbb_leaderName").each {|name| fighter_names << name.text}

        # Rank
        fighter_rank = []
        doc.css("span.wisbb_leaderRank").each {|num|fighter_rank << num.text}
        fighter_rank.insert(6, "6")

        # # Record
        # records = []
        # doc.css("span.wisbb_leaderValue").each {|record| records << record.text}

        # Heavyweight Rankings
        name = 0
        rank = 0
        record = 0
        spots = 0
        puts "UFC RANKINGS"
        puts "\n"
        puts doc.css("span.wisbb_leaderTitle").first.text
        while spots != 16
            puts "#{fighter_rank.uniq[rank]}. #{fighter_names[name]}"
                name += 1
                rank += 1
                spots += 1
                @@o_h = 1
        end
        fighter_names.clear
        fighter_rank.clear
        next_step
    end

    def scrape_pfp
        doc = Nokogiri::HTML(open("https://www.foxsports.com/ufc/rankings"))
        UfcCLI::Scraper.new.scrape_pound_for_pound
    end

    def pound_for_pound

        doc = Nokogiri::HTML(open("https://www.foxsports.com/ufc/rankings"))
        # Fighter names
        fighter_names = []
        doc.css("span.wisbb_leaderName").each {|name| fighter_names << name.text}

        # Rank
        fighter_rank = []
        doc.css("span.wisbb_leaderRank").each {|num|fighter_rank << num.text}
        fighter_rank.insert(6, "6")


        # Pound for Pound Rankings
        name = 16
        rank = 1
        spots = 0
        puts "UFC RANKINGS"
        puts "\n"
        puts doc.css("span.wisbb_leaderTitle")[1].text
        while spots != 15
            puts "#{fighter_rank.uniq[rank]}. #{fighter_names[name]}"
                name += 1
                rank += 1
                spots += 1
                @@o_pfp = 1
        end
        fighter_names.clear
        fighter_rank.clear
        next_step
    end

    def scrape_lh
        doc = Nokogiri::HTML(open("https://www.foxsports.com/ufc/rankings"))
        UfcCLI::Scraper.new.scrape_light_heavyweights
    end


    def light_heavyweight

        doc = Nokogiri::HTML(open("https://www.foxsports.com/ufc/rankings"))
        # Fighter names
        fighter_names = []
        doc.css("span.wisbb_leaderName").each {|name| fighter_names << name.text}

        # Rank
        fighter_rank = []
        doc.css("span.wisbb_leaderRank").each {|num|fighter_rank << num.text}
        fighter_rank.insert(6, "6")

        # Light Heavyweight Rankings
        name = 31
        rank = 0
        spots = 0
        puts "UFC RANKINGS"
        puts "\n"
        puts doc.css("span.wisbb_leaderTitle")[2].text
        while spots != 16
            puts "#{fighter_rank.uniq[rank]}. #{fighter_names[name]}"
                name += 1
                rank += 1
                spots += 1
                @@o_lh = 1
        end
        fighter_names.clear
        fighter_rank.clear
        next_step
    end

    def scrape_mw
        doc = Nokogiri::HTML(open("https://www.foxsports.com/ufc/rankings"))
        UfcCLI::Scraper.new.scrape_middleweights
    end


    def middleweight

        doc = Nokogiri::HTML(open("https://www.foxsports.com/ufc/rankings"))
        # Fighter names
        fighter_names = []
        doc.css("span.wisbb_leaderName").each {|name| fighter_names << name.text}

        # Rank
        fighter_rank = []
        doc.css("span.wisbb_leaderRank").each {|num|fighter_rank << num.text}
        fighter_rank.insert(6, "6")

        # Middleweight Rankings
        name = 47
        rank = 0
        spots = 0
        puts "UFC RANKINGS"
        puts "\n"
        puts doc.css("span.wisbb_leaderTitle")[3].text
        while spots != 16
            puts "#{fighter_rank.uniq[rank]}. #{fighter_names[name]}"
                name += 1
                rank += 1
                spots += 1
                @@o_lh = 1
        end
        fighter_names.clear
        fighter_rank.clear
        next_step
    end

    def scrape_ww
        doc = Nokogiri::HTML(open("https://www.foxsports.com/ufc/rankings"))
        UfcCLI::Scraper.new.scrape_welterweights
    end


    def welterweight

        doc = Nokogiri::HTML(open("https://www.foxsports.com/ufc/rankings"))
        # Fighter names
        fighter_names = []
        doc.css("span.wisbb_leaderName").each {|name| fighter_names << name.text}

        # Rank
        fighter_rank = []
        doc.css("span.wisbb_leaderRank").each {|num|fighter_rank << num.text}
        fighter_rank.insert(6, "6")

        # Welterweight Rankings
        name = 63
        rank = 0
        spots = 0
        puts "UFC RANKINGS"
        puts "\n"
        puts doc.css("span.wisbb_leaderTitle")[4].text
        while spots != 16
            puts "#{fighter_rank.uniq[rank]}. #{fighter_names[name]}"
                name += 1
                rank += 1
                spots += 1
                @@o_lw = 1
        end
        fighter_names.clear
        fighter_rank.clear
        next_step
    end

    def womens_bantamweight

        doc = Nokogiri::HTML(open("https://www.foxsports.com/ufc/rankings"))
        # Fighter names
        fighter_names = []
        doc.css("span.wisbb_leaderName").each {|name| fighter_names << name.text}

        # Rank
        fighter_rank = []
        doc.css("span.wisbb_leaderRank").each {|num|fighter_rank << num.text}
        fighter_rank.insert(6, "6")
        # fighter_rank

        # Womens Bantamweight Rankings
        name = 142
        rank = 0
        spots = 0
        puts "UFC RANKINGS"
        puts "\n"
        puts doc.css("span.wisbb_leaderTitle")[9].text
        while spots != 16
            puts "#{fighter_rank.uniq[rank]}. #{fighter_names[name]}"
                name += 1
                rank += 1
                spots += 1
        end

    end

    def womens_strawweight

        doc = Nokogiri::HTML(open("https://www.foxsports.com/ufc/rankings"))
        # Fighter names
        fighter_names = []
        doc.css("span.wisbb_leaderName").each {|name| fighter_names << name.text}

        # Rank
        fighter_rank = []
        doc.css("span.wisbb_leaderRank").each {|num|fighter_rank << num.text}
        fighter_rank.insert(6, "6")
        # fighter_rank

        # Womens Strawweight Rankings
        name = 158
        rank = 0
        spots = 0
        puts "UFC RANKINGS"
        puts "\n"
        puts doc.css("span.wisbb_leaderTitle")[10].text
        while spots != 16
            puts "#{fighter_rank.uniq[rank]}. #{fighter_names[name]}"
                name += 1
                rank += 1
                spots += 1
        end
    end


end



        # doc.css("div.wisbb_leaderList").each do |project|

        #     weight_class = project.css("span.wisbb_leaderTitle")[0].text
        #     fighter_name = project.css("span.wisbb_leaderName")[0].text
        #     fighter_rank = project.css("span.wisbb_leaderRank")[0].text
        #     fighter_record = project.css("span.wisbb_leaderValue")[0].text

        # fighter_cards << {:name => fighter_name, :weight => weight_class, :rank => fighter_rank, :record => fighter_record}

        # end



















#     def start
#         puts "Hello there!"
#         puts "GETTING DATA FROM API ... PLEASE WAIT"
#         @objects = UfcCLI::Stuff.all
#         display_info
#     end

#     def display_info
#         puts "please make selection:"
#         input = gets.strip.downcase
#         if input == "actors"
#             puts "==========ACTORS LIST=============="
#             puts "LIST OF ACTORS/OBJS"
#             # 1. Tom Crusie
#             # 2. Anne Hathway
#         elsif input == "movies"
#             puts "==========MOVIES LIST=============="
#             puts "LIST OF MOVIES/OBJS"
#         else
#             quit
#         end
#     end

#     def quit
#         puts "goodbye"
#     end

# end

    # deal with inputs(loop to keep asking to get new info)
    # EX. while input != "exit" do
    # display a list of something, or give examples of what we expect as input
    # get user input
    # depending on what we get, do something
    # condition to check input or good value
    # else tell them try again

    # exit command
    # if input == "EXIT"
    # kill program. say goodbye



