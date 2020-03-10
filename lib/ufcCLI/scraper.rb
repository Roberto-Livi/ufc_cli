
# ========= Attributes ==========

# First Name: soc.css("span.wisbb_firstName").text
# Last Name: soc.css("span.wisbb_lastName").text
# Nickname: soc.css(".wisbb_secondaryInfo span").children[0].text
# D.O.B: soc.css(".wisbb_playerData tr").children[3].text
# Weight Class: soc.css(".wisbb_secondaryInfo span").children[2].text
# Location: soc.css(".wisbb_playerData tr").children[13].text.strip
# Reach: soc.css(".wisbb_playerData tr").children[18].text
# Stance: soc.css(".wisbb_playerData tr").children[23].text

class UfcCLI::Scraper

    def rankings_page
        Nokogiri::HTML(open("https://www.foxsports.com/ufc/rankings"))
    end

    def scrape_heavyweights
        puts "Loading UFC Heavyweights"
        countdown = 13
        count = 0
        num_of_urls = 14
        while count != num_of_urls
            if self.rankings_page.css("span.wisbb_leaderName").css("a")[count].attributes["href"].value.include?("/ufc/shamil-abdurahimov-fighter-stats") || self.rankings_page.css("span.wisbb_leaderName").css("a")[count].attributes["href"].value.include?("/ufc/olexiy-oliynyk-fighter-stats")
                count += 1
            else
                UfcCLI::RosterInfo.new_fighter(self.rankings_page.css("span.wisbb_leaderName").css("a")[count].attributes["href"].value)
                puts countdown
            countdown -= 1
            count += 1
            end
        end
    end

    def scrape_pound_for_pound
        puts "Loading the best Pound for Pound fighters in UFC"
        countdown = 14
        url = 16
        count = 1
        num_of_urls = 16
        while count != num_of_urls
            if self.rankings_page.css("span.wisbb_leaderName").css("a")[url].attributes["href"].value.include?("/ufc/alex-volkanovski-fighter-stats")
                count += 1
                url += 1
            else
                UfcCLI::RosterInfo.new_fighter(self.rankings_page.css("span.wisbb_leaderName").css("a")[url].attributes["href"].value)
                puts countdown
                countdown -= 1
                count += 1
                url += 1
            end
        end
    end


    def scrape_light_heavyweights
        puts "Loading UFC Light Heavyweights"
        countdown = 15
        url = 31
        count = 1
        num_of_urls = 17
        while count != num_of_urls
            UfcCLI::RosterInfo.new_fighter(self.rankings_page.css("span.wisbb_leaderName").css("a")[url].attributes["href"].value)
            puts countdown
            countdown -= 1
            count += 1
            url += 1
        end
    end

    def scrape_middleweights
        puts "Loading UFC Middleweights"
        countdown = 15
        url = 47
        count = 1
        num_of_urls = 17
        while count != num_of_urls
            if self.rankings_page.css("span.wisbb_leaderName").css("a")[url].attributes["href"].value.include?("/ufc/paulo-borrachinha-fighter-stats")
                count += 1
                url += 1
            else
                UfcCLI::RosterInfo.new_fighter(self.rankings_page.css("span.wisbb_leaderName").css("a")[url].attributes["href"].value)
                puts countdown
                countdown -= 1
                count += 1
                url += 1
            end
        end
    end

    def scrape_welterweights
        puts "Loading UFC Welterweights"
        countdown = 15
        url = 63
        count = 1
        num_of_urls = 17
        while count != num_of_urls
            UfcCLI::RosterInfo.new_fighter(self.rankings_page.css("span.wisbb_leaderName").css("a")[url].attributes["href"].value)
            puts countdown
            countdown -= 1
            count += 1
            url += 1
        end
    end

    def scrape_lightweights
        puts "Loading UFC Lightweights"
        countdown = 15
        url = 79
        count = 1
        num_of_urls = 17
        while count != num_of_urls
            if self.rankings_page.css("span.wisbb_leaderName").css("a")[url].attributes["href"].value.include?("/ufc/carlos-diego-ferreira-fighter-stats")
                count += 1
                url += 1
            else
                UfcCLI::RosterInfo.new_fighter(self.rankings_page.css("span.wisbb_leaderName").css("a")[url].attributes["href"].value)
                puts countdown
                countdown -= 1
                count += 1
                url += 1
            end
        end
    end

    def scrape_featherweights
        puts "Loading UFC Featherweights"
        countdown = 15
        url = 95
        count = 1
        num_of_urls = 17
        while count != num_of_urls
            if self.rankings_page.css("span.wisbb_leaderName").css("a")[url].attributes["href"].value.include?("/ufc/alex-volkanovski-fighter-stats")
                count += 1
                url += 1
            else
                UfcCLI::RosterInfo.new_fighter(self.rankings_page.css("span.wisbb_leaderName").css("a")[url].attributes["href"].value)
                puts countdown
                countdown -= 1
                count += 1
                url += 1
            end
        end
    end

    def scrape_bantamweights
        puts "Loading UFC Men's Bantamweights"
        countdown = 15
        url = 111
        count = 1
        num_of_urls = 17
        while count != num_of_urls
            if self.rankings_page.css("span.wisbb_leaderName").css("a")[url].attributes["href"].value.include?("/ufc/casey-kenney-fighter-stats")
                count += 1
                url += 1
            else
                UfcCLI::RosterInfo.new_fighter(self.rankings_page.css("span.wisbb_leaderName").css("a")[url].attributes["href"].value)
                puts countdown
                countdown -= 1
                count += 1
                url += 1
            end
        end
    end

    def scrape_flyweights
        puts "Loading UFC Flyweights"
        countdown = 15
        url = 127
        count = 1
        num_of_urls = 17
        while count != num_of_urls
            if self.rankings_page.css("span.wisbb_leaderName").css("a")[url].attributes["href"].value.include?("/ufc/deiveson-alcantara-fighter-stats") || self.rankings_page.css("span.wisbb_leaderName").css("a")[url].attributes["href"].value.include?("/ufc/askar-askarov-fighter-stats") || self.rankings_page.css("span.wisbb_leaderName").css("a")[url].attributes["href"].value.include?("/ufc/timothy-elliott-fighter-stats") || self.rankings_page.css("span.wisbb_leaderName").css("a")[url].attributes["href"].value.include?("/ufc/jordan-espinosa-fighter-stats")
                count += 1
                url += 1
            else
                UfcCLI::RosterInfo.new_fighter(self.rankings_page.css("span.wisbb_leaderName").css("a")[url].attributes["href"].value)
                puts countdown
                countdown -= 1
                count += 1
                url += 1
            end
        end
    end

    def scrape_womens_bantamweights
        puts "Loading UFC Women's Bantamweights"
        countdown = 15
        url = 142
        count = 1
        num_of_urls = 17
        while count != num_of_urls
            UfcCLI::RosterInfo.new_fighter(self.rankings_page.css("span.wisbb_leaderName").css("a")[url].attributes["href"].value)
            puts countdown
            countdown -= 1
            count += 1
            url += 1
        end
    end

    def scrape_womens_strawweights
        puts "Loading UFC Women's Strawweights"
        countdown = 14
        url = 159
        count = 1
        num_of_urls = 15
        while count != num_of_urls
            UfcCLI::RosterInfo.new_fighter(self.rankings_page.css("span.wisbb_leaderName").css("a")[url].attributes["href"].value)
            puts countdown
            countdown -= 1
            count += 1
            url += 1
        end
    end

end
