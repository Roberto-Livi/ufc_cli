# find api to
# use set url
# build hashes out for objs
# call custom class .new method
# send those back to our CLI

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
    @@url_array = []

    def rankings_page
        Nokogiri::HTML(open("https://www.foxsports.com/ufc/rankings"))
    end

    def scrape_heavyweights
        puts "Loading UFC Heavyweights"
        time = 12
        count = 0
        num_of_urls = 14
        while count != num_of_urls
            if self.rankings_page.css("span.wisbb_leaderName").css("a")[count].attributes["href"].value.include?("/ufc/shamil-abdurahimov-fighter-stats") || self.rankings_page.css("span.wisbb_leaderName").css("a")[count].attributes["href"].value.include?("/ufc/olexiy-oliynyk-fighter-stats") || self.rankings_page.css("span.wisbb_leaderName").css("a")[count].attributes["href"].value.include?("/ufc/ciryl-gane-fighter-stats")
                count += 1
            else
                UfcCLI::RosterInfo.new_fighter(self.rankings_page.css("span.wisbb_leaderName").css("a")[count].attributes["href"].value)
                puts time
            time -= 1
            count += 1
            end
        end
    end

    def scrape_pound_for_pound
        puts "Loading the best Pound for Pound fighters in UFC"
        time = 14
        url = 16
        count = 1
        num_of_urls = 16
        while count != num_of_urls
            if self.rankings_page.css("span.wisbb_leaderName").css("a")[url].attributes["href"].value.include?("/ufc/alex-volkanovski-fighter-stats")
                count += 1
                url += 1
            else
                UfcCLI::RosterInfo.new_fighter(self.rankings_page.css("span.wisbb_leaderName").css("a")[url].attributes["href"].value)
                puts time
                time -= 1
                count += 1
                url += 1
            end
        end
    end

    def scrape_light_heavyweights
        puts "Loading UFC Light Heavyweights"
        time = 14
        url = 16
        count = 1
        num_of_urls = 16
        while count != num_of_urls
            if self.rankings_page.css("span.wisbb_leaderName").css("a")[url].attributes["href"].value.include?("/ufc/alex-volkanovski-fighter-stats")
                count += 1
                url += 1
            else
                UfcCLI::RosterInfo.new_fighter(self.rankings_page.css("span.wisbb_leaderName").css("a")[url].attributes["href"].value)
                puts time
                time -= 1
                count += 1
                url += 1
            end
        end
    end

end

# || self.rankings_page.css("span.wisbb_leaderName").css("a")[count].attributes["href"].value.include?("/ufc/alex-volkanovski-fighter-stats") || self.rankings_page.css("span.wisbb_leaderName").css("a")[count].attributes["href"].value.include?("/ufc/paulo-borrachinha-fighter-stats") || self.rankings_page.css("span.wisbb_leaderName").css("a")[count].attributes["href"].value.include?("/ufc/carlos-diego-ferreira-fighter-stats") || self.rankings_page.css("span.wisbb_leaderName").css("a")[count].attributes["href"].value.include?("/ufc/casey-kenney-fighter-stats") || self.rankings_page.css("span.wisbb_leaderName").css("a")[count].attributes["href"].value.include?("/ufc/deiveson-alcantara-fighter-stats") || self.rankings_page.css("span.wisbb_leaderName").css("a")[count].attributes["href"].value.include?("/ufc/askar-askarov-fighter-stats") || self.rankings_page.css("span.wisbb_leaderName").css("a")[count].attributes["href"].value.include?("/ufc/timothy-elliott-fighter-stats") || self.rankings_page.css("span.wisbb_leaderName").css("a")[count].attributes["href"].value.include?("/ufc/jordan-espinosa-fighter-stats") || self.rankings_page.css("span.wisbb_leaderName").css("a")[count].attributes["href"].value.include?("/ufc/weili-zhang-fighter-stats") || self.rankings_page.css("span.wisbb_leaderName").css("a")[count].attributes["href"].value.include?("/ufc/amanda-ribas-fighter-stats") || self.rankings_page.css("span.wisbb_leaderName").css("a")[count].attributes["href"].value.include?("/ufc/sergey-pavlovich-fighter-stats")