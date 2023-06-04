//
//  CharacterView.swift
//  GatsbyBot
//
//  Created by Cooper Hopkins on 5/31/23.
//

import SwiftUI

struct CharacterView: View {
    //Basic Variables
    
    //View Specific Variables
    @State var character : String
    @State var charDescription = ""
    let characters = ["Nick Carraway","James Gatz", "Jay Gatsby", "Daisy Buchanan", "Tom Buchanan", "Jordan Baker", "George Wilson", "Mr. Gatz", "Meyer Wolfsheim", "Myrtle Wilson", "Owl Eyes", "Klipspringer"]
    @State var characterTraits : [[String]] = []
    @State var selectedCharacterTraits : [String] = []
    let gradientBackgrounds : [[Color]] = [[Color.white, Color.gray], [Color.white, Color.blue], [Color.white, Color.yellow], [Color.white, Color.pink.opacity(0.8)], [Color.white, Color.red.opacity(0.9)], [Color.white, Color.pink], [Color.white, Color.red], [Color.white, Color.yellow], [Color.white, Color.brown.opacity(0.5)], [Color.white, Color.orange], [Color.white, Color.mint], [Color.white, Color.purple]]
    @State var selectedCharBGC : Int = 0
    //Do seperate Jay Gatsby and James Gatz
    
    //Functions
    func fetchCharacterTraits() {
        if let characterTraitData = UserDefaults.standard.data(forKey: "characterTraitsJSON") {
            let decodedTraitData = try? JSONDecoder().decode([[String]].self, from: characterTraitData)
            characterTraits = decodedTraitData ?? [[]]
        }
        //Delete When Done //
        characterTraits = [["Narrator", "Reserved", "Observant", "Moderately Wealtyh"], ["Ambitious", "Persistent", "Idealistic", "Not Wealthy"], ["Hopeful", "Obsessive", "Socially Awkward", "Extremely Wealthy"], ["Passive", "Flighty", "Superficial", "Wealthy"], ["Arrogant", "Large", "Aggressive", "Wealthy"], ["Athletic", "Unemotional", "Independent", "Wealthy"], ["Desperate", "Obsessive", "Unassuming", "Poor"], ["Supportive", "Humble", "Optimistic", "Middle Class"], ["Mysterious", "Cautious", "Criminal", "Wealthy"], ["Ambitious", "Trapped", "Reckless", "Poor"], ["Eccentric", "Knowledgeable", "Curious", "Sarcastic"], ["Opportunistic", "Disloyal", "Superficial", "Moderately Wealthy"]]
        //
        
        //Assign Char Trait
        selectedCharacterTraits = characterTraits[characters.firstIndex(of: character) ?? 0]
        print(selectedCharacterTraits)
        print(character)
    }
    //Generate Background Color
    func generateBGC(selectedChar: String) -> Int {
        var colorInt = 0
        switch selectedChar {
        case "Nick Carraway":
            colorInt = 0
        case "James Gatz":
            colorInt = 1
        case "Jay Gatsby":
            colorInt = 2
        case "Daisy Buchanan":
            colorInt = 3
        case "Tom Buchanan":
            colorInt = 4
        case "Jordan Baker":
            colorInt = 5
        case "George Wilson":
            colorInt = 6
        case "Mr. Gatz":
            colorInt = 7
        case "Meyer Wolfsheim":
            colorInt = 8
        case "Myrtle Wilson":
            colorInt = 9
        case "Owl Eyes":
            colorInt = 10
        case "Klipspringer":
            colorInt = 11
        default:
            colorInt = 0
        }
        return colorInt
    }
    
    //Generate Description
    func generateDescription(selectedChar: String) -> String {
        var retCharDescription = ""
        switch selectedChar {
        case "Nick Carraway":
            retCharDescription = "Hello, I am Nick Carraway and I serve as the narrator throughout the entire text. Though I may not seem physically present in all the text, I was there."
        case "James Gatz":
            retCharDescription = "Hi, I'm James Gatz. I later become Jay Gatsby, however I always had a desire for wealth, even though I was not born into it. I was also highly influenced by Dan Cody, a very wealthy person who left me $25,000 when he died (roughly $380,000 today. I fell in love with Daisy at a young age and also fought in The Great War, alongside Mr. Carraway."
        case "Jay Gatsby":
            retCharDescription = "Hello, I am Jay Gatsby. I wasn't always wealthy, however I always wanted to be, though how I eventually got my wealth is ethcially questionable, old sport. I try to give off a confident and charismatic image, even though I seem to blend in with the guests at my extravagant parties, however, around Daisy, who I have loved for many a year, I become quite awkward."
        case "Daisy Buchanan":
            retCharDescription = "Hello, my name is Daisy Buchanan. I used to be romantically involved with Jay, but after he went off to war I just couldn't wait for him so I married Tom. I despise Tom for cheating on me, and while I still love Tom, I also still love Jay. I do tend to be bad at making decisions and I tend to take the flight option in my fight or flight reaction."
        case "Tom Buchanan":
            retCharDescription = "Hello, I am Tom Buchanan, though I'm sure you've heard of me before. I may not be loyal to one partner, but I'm Tom Buchanan for crying out loud. I'm a physically large person with a temper so just don't argue with me, I will win any confrontation. I also come from old money, not like that Gatsby fellows new money he probably got from selling alcohol illegaly might I add."
        case "Jordan Baker":
            retCharDescription = "Hello, I am known as Jordan Baker. I am a professional golfer with a high level of intellect. I prefer being independent, though I have some fondness for Nick. I represent the changing woman of the 1920s pretty well, and I tend to be quite unapologetic. Just to add, I made my wealth; I do not need a man to rely on for self-fulfillment."
        case "George Wilson":
            retCharDescription = "Hey, I'm George Wilson. I really love my wife Myrtle, I think I'd go crazy if anything happened to her. I'm not a very physicall present man, nor am I assertive in really any nature. If only I could get the money to move me and my beloved wife Myrtle out west, finally fulfilling her dream; maybe when Tom sells me that car."
        case "Mr. Gatz":
            retCharDescription = "Hello there! I am Mr. Gatz, Jay Gatsby's Father. I always knew my son would be wealthy, it's been his life's goal since he was very young, and I'm glad he accomplished his goal. Though I myself was never wealthy, I worked to raise my son well and always made sure I could provide for him."
        case "Meyer Wolfsheim":
            retCharDescription = "Hello, who are you? Nevertheless, I am Meyer Wolfsheim. I am also an Oggsford graduate, did you know that Gatsby went to Oggsford as well? Me and Gatsby have done plenty of business together; since the moment I met him I knew he would be a great addition to my business ventures. I'm just happy that the players in the 1919 World Series game accepted my propsition, it made me and my friends a lot of money."
        case "Myrtle Wilson":
            retCharDescription = "Hey, I'm Myrtle Wilson. Is Tom with you? No? Ok, I'll just call him around dinner time. Maybe we can go out and get me away from George. I like him, I just wish he had more money. Maybe some day me and Tom can escape out west, away from this dreaded place. They say money can't buy happiness however that's a blatant lie, I've seen it, in this day and age, money is everything."
        case "Owl Eyes":
            retCharDescription = "Hello, I am Owl Eyes. Have you seen Gatsby's library? He's got honest-to-god real books in there! Most people at his level of wealth are all fake, but I can sniff out who's real. Aren't Gatsbys' parties the best, always classy and always fun, plus there's alcohol. If only some of the people here were a bit more, shall we say, intellectually capable, eh?"
        case "Klipspringer":
            retCharDescription = "Hello, I am Klipspringer. I started going to Gatsby's parties so much that one day I just decided to stay. I don't know Gatsby very well but I'm not gonna pass up an opportunity to stay at a place like this, though I do make up for my freeloading with my excellent piano skills."
        default:
            retCharDescription = selectedChar
        }
        
        return retCharDescription
    }
    
    var body: some View {
        VStack {
            VStack {
                //Icon?
                //Name
                Text(character)
                    .font(.system(size: 30))
                    .fontWeight(.bold)
                VStack {
                    //Description
                    Text(charDescription)
                        .padding()
                        .multilineTextAlignment(.center)
                    Divider()
                    //Traits
                    Text("Traits")
                        .font(.system(size: 25))
                        .fontWeight(.medium)
                        .padding([.bottom])
                    ForEach(selectedCharacterTraits, id: \.self) { trait in
                        Text(trait)
                    }
                }
            }
        }
        .foregroundColor(Color.black)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .padding(.bottom, 1)
        //Change Background Color Based On Selected Color
        .background(LinearGradient(colors: gradientBackgrounds[selectedCharBGC], startPoint: .top, endPoint: .bottom))
        .onAppear {
            charDescription = generateDescription(selectedChar: character)
            selectedCharBGC = generateBGC(selectedChar: character)
            fetchCharacterTraits()
        }
        .task {
            charDescription = generateDescription(selectedChar: character)
            selectedCharBGC = generateBGC(selectedChar: character)
            fetchCharacterTraits()
        }
    }
}

struct CharacterView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterView(character: "Jay Gatsby")
    }
}
