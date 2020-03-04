require 'pry'
class UfcCLI::CLI

    # Name: doc.css("span.wisbb_leaderName").text
    # Name: doc.css("span.wisbb_leaderName")[28].text
    # Weight Class: doc.css("span.wisbb_leaderTitle").text
    # Record: doc.css("span.wisbb_leaderValue").text
    # Rank: doc.css("span.wisbb_leaderRank").text


    @@o_h = 0
    @@o_pfp = 0
    @@o_lh = 0
    @@o_mw = 0
    @@o_ww = 0
    @@o_lw = 0
    @@o_fw = 0
    @@o_bw = 0
    @@o_flyweight = 0
    @@o_wb = 0
    @@o_ws = 0



    def start

        puts "Welcome UFC fans!"
        puts "GETTING DATA FROM API ... PLEASE WAIT"
        doc = Nokogiri::HTML(open("https://www.foxsports.com/ufc/rankings"))
        puts "Which division do you want to see?\n1) Men\n2) Women"
        input = gets.chomp()
        if input  == "1"

            puts "Which weight class would you like to see?"
            puts "1) Pound for Pound\n2) Heavyweight\n3) Light Heavyweight\n4) Middleweight\n5) Welterweight\n6) Lightweight\n7) Featherweight\n8) Bantamweight\n9) Flyweight"
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
            when '6'
                if @@o_lw == 0
                    scrape_lw
                    lightweight
                else
                    lightweight
                end
            when '7'
                if @@o_fw == 0
                    scrape_fw
                    featherweight
                else
                    featherweight
                end
            when '8'
                if @@o_bw == 0
                    scrape_bw
                    bantamweight
                else
                    bantamweight
                end
            when '9'
                if @@o_flyweight == 0
                    scrape_flyw
                    flyweight
                else
                    flyweight
                end
            else
                puts "Not an option. Please try again.."
                start
            end

        elsif input == "2"

            puts "Which weight class would you like to see?"
            puts "1) Bantamweight\n2) Strawweight"
            choice_2 = gets.chomp()
            case(choice_2)
            when '1'
                if @@o_wb == 0
                    scrape_w_bantamweights
                    womens_bantamweight
                else
                    womens_bantamweight
                end
            when '2'
                if @@o_ws == 0
                    scrape_w_strawweights
                    womens_strawweight
                else
                    womens_strawweight
                end
            else
                puts "Not an option, please try again"
                start
            end
        else
            puts "Not an option, please try again"
            start
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
                @@o_mw = 1
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
                @@o_ww = 1
        end
        fighter_names.clear
        fighter_rank.clear
        next_step
    end

    def scrape_lw
        doc = Nokogiri::HTML(open("https://www.foxsports.com/ufc/rankings"))
        UfcCLI::Scraper.new.scrape_lightweights
    end


    def lightweight

        doc = Nokogiri::HTML(open("https://www.foxsports.com/ufc/rankings"))
        # Fighter names
        fighter_names = []
        doc.css("span.wisbb_leaderName").each {|name| fighter_names << name.text}

        # Rank
        fighter_rank = []
        doc.css("span.wisbb_leaderRank").each {|num|fighter_rank << num.text}
        fighter_rank.insert(6, "6")

        # Lightweight Rankings
        name = 79
        rank = 0
        spots = 0
        puts "UFC RANKINGS"
        puts "\n"
        puts doc.css("span.wisbb_leaderTitle")[5].text
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

    def scrape_fw
        doc = Nokogiri::HTML(open("https://www.foxsports.com/ufc/rankings"))
        UfcCLI::Scraper.new.scrape_featherweights
    end


    def featherweight

        doc = Nokogiri::HTML(open("https://www.foxsports.com/ufc/rankings"))
        # Fighter names
        fighter_names = []
        doc.css("span.wisbb_leaderName").each {|name| fighter_names << name.text}

        # Rank
        fighter_rank = []
        doc.css("span.wisbb_leaderRank").each {|num|fighter_rank << num.text}
        fighter_rank.insert(6, "6")

        # Featherweight Rankings
        name = 95
        rank = 0
        spots = 0
        puts "UFC RANKINGS"
        puts "\n"
        puts doc.css("span.wisbb_leaderTitle")[6].text
        while spots != 16
            puts "#{fighter_rank.uniq[rank]}. #{fighter_names[name]}"
                name += 1
                rank += 1
                spots += 1
                @@o_fw = 1
        end
        fighter_names.clear
        fighter_rank.clear
        next_step
    end

    def scrape_bw
        doc = Nokogiri::HTML(open("https://www.foxsports.com/ufc/rankings"))
        UfcCLI::Scraper.new.scrape_bantamweights
    end


    def bantamweight

        doc = Nokogiri::HTML(open("https://www.foxsports.com/ufc/rankings"))
        # Fighter names
        fighter_names = []
        doc.css("span.wisbb_leaderName").each {|name| fighter_names << name.text}

        # Rank
        fighter_rank = []
        doc.css("span.wisbb_leaderRank").each {|num|fighter_rank << num.text}
        fighter_rank.insert(6, "6")

        # Bantamweight Rankings
        name = 111
        rank = 0
        spots = 0
        puts "UFC RANKINGS"
        puts "\n"
        puts doc.css("span.wisbb_leaderTitle")[7].text
        while spots != 16
            puts "#{fighter_rank.uniq[rank]}. #{fighter_names[name]}"
                name += 1
                rank += 1
                spots += 1
                @@o_bw = 1
        end
        fighter_names.clear
        fighter_rank.clear
        next_step
    end

    def scrape_flyw
        doc = Nokogiri::HTML(open("https://www.foxsports.com/ufc/rankings"))
        UfcCLI::Scraper.new.scrape_flyweights
    end


    def flyweight

        doc = Nokogiri::HTML(open("https://www.foxsports.com/ufc/rankings"))
        # Fighter names
        fighter_names = []
        doc.css("span.wisbb_leaderName").each {|name| fighter_names << name.text}

        # Rank
        fighter_rank = []
        doc.css("span.wisbb_leaderRank").each {|num|fighter_rank << num.text}
        fighter_rank.insert(6, "6")

        # Flyweight Rankings
        name = 127
        rank = 0
        spots = 0
        puts "UFC RANKINGS"
        puts "\n"
        puts doc.css("span.wisbb_leaderTitle")[8].text
        while spots != 15
            puts "#{fighter_rank.uniq[rank]}. #{fighter_names[name]}"
                name += 1
                rank += 1
                spots += 1
                @@o_flyweight = 1
        end
        fighter_names.clear
        fighter_rank.clear
        next_step
    end

    def scrape_w_bantamweights
        doc = Nokogiri::HTML(open("https://www.foxsports.com/ufc/rankings"))
        UfcCLI::Scraper.new.scrape_womens_bantamweights
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
                @@o_wb = 1
        end
        fighter_names.clear
        fighter_rank.clear
        next_step
    end

    def scrape_w_strawweights
        doc = Nokogiri::HTML(open("https://www.foxsports.com/ufc/rankings"))
        UfcCLI::Scraper.new.scrape_womens_strawweights
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
                @@o_ws = 1
        end
        fighter_names.clear
        fighter_rank.clear
        next_step
    end


end