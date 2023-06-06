//
//  ContentView.swift
//  GatsbyBot
//
//  Created by Cooper Hopkins on 5/31/23.
//

import SwiftUI

struct ContentView: View {
    //Basic Variables
    @State var username = ""
    //Character Info Variables
    //Character Order
    let characters = ["Nick Carraway","James Gatz", "Jay Gatsby", "Daisy Buchanan", "Tom Buchanan", "Jordan Baker", "George Wilson", "Mr. Gatz", "Meyer Wolfsheim", "Myrtle Wilson", "Owl Eyes", "Klipspringer"]
    let characterTraits : [[String]] = [["Narrator", "Reserved", "Observant", "Moderately Wealtyh"], ["Ambitious", "Persistent", "Idealistic", "Not Wealthy"], ["Hopeful", "Obsessive", "Socially Awkward", "Extremely Wealthy"], ["Passive", "Flighty", "Superficial", "Wealthy"], ["Arrogant", "Large", "Aggressive", "Wealthy"], ["Athletic", "Unemotional", "Independent", "Wealthy"], ["Desperate", "Obsessive", "Unassuming", "Poor"], ["Supportive", "Humble", "Optimistic", "Middle Class"], ["Mysterious", "Cautious", "Criminal", "Wealthy"], ["Ambitious", "Trapped", "Reckless", "Poor"], ["Eccentric", "Knowledgeable", "Curious", "Sarcastic"], ["Opportunistic", "Disloyal", "Superficial", "Moderately Wealthy"]]
    //Character Dialogue
    @State var nickUROptions : [[String]] = [[]]
    @State var nickBotOptions : [[String]] = [[]]
    @State var jamesUROptions : [[String]] = [[]]
    @State var jamesBotOptions : [[String]] = [[]]
    @State var gatsbyUROptions : [[String]] = [[]]
    @State var gatsbyBotOptions : [[String]] = [[]]
    @State var daisyUROptions : [[String]] = [[]]
    @State var daisyBotOptions : [[String]] = [[]]
    @State var tomUROptions : [[String]] = [[]]
    @State var tomBotOptions : [[String]] = [[]]
    @State var jordanUROptions : [[String]] = [[]]
    @State var jordanBotOptions : [[String]] = [[]]
    @State var georgeUROptions : [[String]] = [[]]
    @State var georgeBotOptions : [[String]] = [[]]
    @State var gatzUROptions : [[String]] = [[]]
    @State var gatzBotOptions : [[String]] = [[]]
    @State var meyerUROptions : [[String]] = [[]]
    @State var meyerBotOptions : [[String]] = [[]]
    //View Spcific Variables
    @State var welcomeCompleted = false
    @State var appDescriptionCompleted = false
    
    //Functions
    //Generate Dialogue
    func generateEverything() {
        //Give responses a trait and then for each input confer whether or not the input agrees with any of these traits for the character that the user is interacting with
        //Store Character Sentiment, if sentiment too low character will refuse to interact
        //Add a reset button that resets everything and has you restart
        //Encode
        if let encoded = try? JSONEncoder().encode(characterTraits) {
            UserDefaults.standard.set(encoded, forKey: "characterTraitsJSON")
        }
        //Encode all character like as array and start at 0.5 for all
        //Generate Dialogue
        //Nick Carraway Options
        nickUROptions = [["positive:Hello, I'm \(username.capitalized), how do you know Gatsby?", "neutral:Hello, I'm \(username.capitalized), who are you?", "negative:Hey, I'm \(username.capitalized), are you another one of those freeloaders at his parties?"], ["positive:That nice house over there?", "neutral: That house over there?", "negative:That tiny shack over there?"], ["positive:Nick you seem like you are in deep thought, is there something you want to talk about?", "neutral:Nick are you preoccupied with something?", "negative:Nick you don't seem very focused on this conversation."], ["positive:What are you thinking about?", "neutral:What's up?", "negative:Well if you talk about it, maybe you can focus on the conversation."], ["positive:Wow! There's more to the story though isn't there?", "neutral:Go on...", "negative:Anything else? Chop chop."], ["neutral: Wow, that is quite a lot, unfortunately I have to leave right now."]]
        nickBotOptions = [["positive:Hi, I'm Nick, I actually just moved in near Gatsby, though I'm not as wealthy", "neutral:I'm Nick, I actually recently met Gatsby, I live in a house near him", "negative:No I most certainly am not, boy are you rude. I am Nick Carraway and I live near Gatsby."], ["positive:Yeah, that's my house, though it's not as fancy as the surrounding ones.", "neutral:Yes, that's my house.", "negative:Yeah, that's my house, but at least I live in the West Egg, unlike you."], ["positive:Sorry, I've had a lot going on. Did you know that Gatsby is in love with Daisy?", "neutral:I've got a lot going on, Gatsby's trying to regain Daisy's love.", "negative:I'm a busy person. Every day I have to help Gatsby and Daisy rekindle their love, sometimes I'm just busy"], ["positive:Well Gatsby proclaimed his love for Daisy, and she essentially rejected him, saying she also loves Tom. Gatsby is devestated.", "neutral:Gatsby was rejected by Daisy which devestated him.", "negative:Daisy rejected Gatsby."], ["positive:Well, apparently, Daisy ran someone over in Gatsby's car, and now Gatsby is waiting outside her house because he is afraid Tom will harm her after today's events", "neutral:Daisy ran someone over in Gatsby's car", "negative:Daisy hit someone."], ["neutral:Goodbye."]]
        //Gatsby Options
        gatsbyUROptions = [["positive:Hello?", "neutral:Who is this?", "negative:Hey there illegal bootlegger!"], ["positive:Hello! I'm \(username.capitalized)", "neutral:I'm \(username.capitalized)", "negative:I'm \(username.capitalized), But You Should Already Know That"], ["positive:You have such a large house, how'd you afford it?", "neutral:How'd you get your wealth?", "negative:What illegal activities did a guy like you do to get all your money?"], ["positive:Have you heard of Daisy Buchanan?", "neutral:Do you know Tom Buchanan's wife Daisy?", "negative:Have you heard of Tom Buchanan's loving wife Daisy?"], ["positive:Gatsby, why'd you decide to build this great house here?", "neutral:Why'd you move here?", "negative:Why'd you build your house here? The West Egg is supposed to be nicer than the East, though after seeing Tom's house in comparison I'm not so sure."], ["positive:Have you seen Daisy recently?", "neutral:Have you seen Daisy recenty? Tom's looking for her","negative:Have you seen Daisy recently? Her husband is looking for her."], ["positive:Gatsby, I saw a bunch of people in town looking for work, they looked like some of your former servants, do you know of this?", "neutral:Gatsby, did you get new servants?", "negative:Gatsby did you fire a bunch of your servants?"], ["positive:Hey Gatsby, with all the money you have you must have a great car, could you take me for a ride in it?", "neutral:Hey Gatsby, can you take me for a ride in your car?", "negative:Tom claims he has a vastly superior car to yours, can I see yours to confirm if this is true?"], ["positive:Hey Gatsby, I haven't seen you in a while, where are you?", "neutral:Gatsby, where have you been?", "negative:Gatsby, disappearing like this only adds to your shadiness, where are you?"], ["positive:Yes, of course I'll come", "neutral:Sure, I'll come", "negative:Well, I've been quite busy recently, I'll see if I can make it."]]
        gatsbyBotOptions = [["positive:Hello there old sport, I’m Jay Gatsby", "neutral:Hello, I’m Mr. Gatsby", "negative:How preposterous! Who are you and what do you want?!"], ["positive:Nice To Meet You!", "neutral:Well, hello", "negative:ok...and?"], ["positive:I had a desire to be rich from a young age and worked hard to get here", "neutral:I made some good financial decisions", "negative:I do not like this line of questioning"], ["positive:Why of course I've heard of her, I've known her for a while.", "neutral:Yes, I've met her", "negative:Yes, I've met her, though I wouldn't exactly say she loves Tom."], ["positive:Well actually, I moved here because Daisy lives close by. Her and I have known each other for a long time, old sport.", "neutral:I moved here because Daisy lives close by.", "negative:I moved here cause of Daisy, but the better question is why are you ruining this area with your tiny shack?"], ["positive:Why yes, I actually saw Daisy earlier today.", "neutral:She was here earlier.", "negative:Yep."], ["positive:Yes, I replaced all my old servants today with more professional ones, in hopes of pleasing Daisy.", "neutral:Yes, I replaced my old servants.", "negative:Yes, the old crappy servants were stealing from me so I had to get more professional ones."], ["positive:Yes, I would, however my car was recently damaged by Daisy, of course it was just an accident so I won't allow any blame to be placed on her.", "neutral:Yes, after I take it to the shop, you see, my car was recently damaged in an accident while driving, old sport.", "negative:What do you think of me? You think that lowlife Tom has a better car than me, fat chance."], ["positive:Hey, this is Gatsby's father, unfortunately Gatsby was murdered, however his funeral is soon and I've heard you knew him well, you will come right?", "neutral:Hey, this is Gatsby's father, unfortuantely Gatsby died, his funeral is soon though, will you come?", "negative:Hey, this is Gatsby's father, unfortunately Gatsby has died, his funeral is soon, though I don't know if he'd want you there, it is open to all though."], ["positive:Thank you", "neutral:Thank you", "negative:Ok..."]]
        //Daisy Dialogue
        daisyUROptions = [["neutral:Hello"], ["neutral:HELLO!"]]
        daisyBotOptions = [["neutral:Daisy does not respond"], ["neutral:(You hear in the distance 'Tom can I answer the door?', no one emerges from the house)"]]
        //Tom Dialogue
        tomUROptions = [["neutral:Hello"], ["neutral:Wait..."]]
        tomBotOptions = [["neutral:Hello, I'm busy, goodbye."], ["neutral:(Tom is gone before you can respond)"]]
        //Meyer Dialogue
        meyerUROptions = [["neutral:Hello, who is this?"], ["neutral:What type of business?"]]
        meyerBotOptions = [["neutral:Hello, unfortunately I have some, shall we say, business to attend to. Goodbye."], ["neutral:You ask too many questions, I don't want to talk to you."]]
        //Encode Dialogue
        let responseOptions = [nickUROptions, jamesUROptions, gatsbyUROptions, daisyUROptions, tomUROptions, jordanUROptions, georgeUROptions, gatzUROptions, meyerUROptions]
        let botResponseOptions = [nickBotOptions, jamesBotOptions, gatsbyBotOptions, daisyBotOptions, tomBotOptions, jordanBotOptions, georgeBotOptions, gatzBotOptions, meyerBotOptions]
        for i in 0..<responseOptions.count {
            if let encoded = try? JSONEncoder().encode(responseOptions[i]) {
                //For Testing Use Characters[2] (Jay Gatsby)
                UserDefaults.standard.set(encoded, forKey: "\(characters[i])UROptionsJSON")
            }
            if let encoded = try? JSONEncoder().encode(botResponseOptions[i]) {
                UserDefaults.standard.set(encoded, forKey: "\(characters[i])BotOptionsJSON")
            }
        }
    }
    
    var body: some View {
        VStack {
            if (welcomeCompleted == false && appDescriptionCompleted == false) {
                WelcomeView(complete: $welcomeCompleted)
            } else if (welcomeCompleted == true && appDescriptionCompleted == false) {
                AppDescriptionView(complete: $appDescriptionCompleted)
            } else if (welcomeCompleted == true && appDescriptionCompleted == true) {
                TabView {
                    //Chat View
                    ChatView()
                        .tabItem {
                            Label("Chat", systemImage: "ellipsis.message")
                        }
                    //Character View
                    CharacterListView()
                        .tabItem {
                            Label("Characters", systemImage: "person.text.rectangle")
                            
                        }
                }
            }
        }
        .onChange(of: welcomeCompleted) {_ in
            //Decode Username
            if let usernameData = UserDefaults.standard.data(forKey: "usernameJSON") {
                let decodedUsernameData = try? JSONDecoder().decode(String.self, from: usernameData)
                username = decodedUsernameData ?? ""
            }
            print("PLEASE BE USERNAME:", username)
            generateEverything()
        }
        .onAppear {
            //Decode Username
            if let usernameData = UserDefaults.standard.data(forKey: "usernameJSON") {
                let decodedUsernameData = try? JSONDecoder().decode(String.self, from: usernameData)
                username = decodedUsernameData ?? ""
            }
        }
        .task {
            
            //Give responses a trait and then for each input confer whether or not the input agrees with any of these traits for the character that the user is interacting with
            //Store Character Sentiment, if sentiment too low character will refuse to interact
            //Add a reset button that resets everything and has you restart
            //Encode
            if let encoded = try? JSONEncoder().encode(characterTraits) {
                UserDefaults.standard.set(encoded, forKey: "characterTraitsJSON")
            }
            //Encode all character like as array and start at 0.5 for all
            //Decode Setup Completions
            if let setupFinishedData = UserDefaults.standard.data(forKey: "setupFinishedJSON") {
                let decodedSetupFinishedData = try? JSONDecoder().decode(Bool.self, from: setupFinishedData)
                welcomeCompleted = decodedSetupFinishedData ?? false
                appDescriptionCompleted = decodedSetupFinishedData ?? false
            }
            //Generate Dialogue
            //Nick Carraway Options
            nickUROptions = [[""]]
            nickBotOptions = [[""]]
            //
            //James Gatz Options
            jamesUROptions = [[""]]
            jamesBotOptions = [[""]]
            //Gatsby Options
            gatsbyUROptions = [["positive:Hello?", "neutral:Who is this?", "negative:Hey there illegal bootlegger!"], ["positive:Hello! I'm \(username.capitalized)", "neutral:I'm \(username.capitalized)", "negative:I'm \(username.capitalized), But You Should Already Know That"], ["positive:You have such a large house, how'd you afford it?", "neutral:How'd you get your wealth?", "negative:What illegal activities did a guy like you do to get all your money?"], ["positive:Have you heard of Daisy Buchanan?", "neutral:Do you know Tom Buchanan's wife Daisy?", "negative:Have you heard of Tom Buchanan's loving wife Daisy?"], ["positive:Gatsby, why'd you decide to build this great house here?", "neutral:Why'd you move here?", "negative:Why'd you build your house here? The West Egg is supposed to be nicer than the East, though after seeing Tom's house in comparison I'm not so sure."]]
            gatsbyBotOptions = [["positive:Hello there old sport, I’m Jay Gatsby", "neutral:Hello, I’m Mr. Gatsby", "negative:How preposterous! Who are you and what do you want?!"], ["positive:Nice To Meet You!", "neutral:Well, hello", "negative:ok...and?"], ["positive:I had a desire to be rich from a young age and worked hard to get here", "neutral:I made some good financial decisions", "negative:I do not like this line of questioning"], ["positive:Why of course I've heard of hear, I've known her for a while.", "neutral:Yes, I've met her", "negative:Yes, I've met her, though I wouldn't exactly say she loves Tom."], ["positive:Well actually, I moved here because Daisy lives close by. Her and I have known each other for a long time, old sport.", "neutral:I moved here because Daisy lives close by.", "negative:I moved here cause of Daisy, but the better question is why are you ruining this area with your tiny shack?"]]
            
            //Encode Dialogue
            let responseOptions = [nickUROptions, jamesUROptions, gatsbyUROptions]
            let botResponseOptions = [nickBotOptions, jamesBotOptions, gatsbyBotOptions]
            for i in 0..<responseOptions.count {
                if let encoded = try? JSONEncoder().encode(responseOptions[i]) {
                    //For Testing Use Characters[2] (Jay Gatsby)
                    UserDefaults.standard.set(encoded, forKey: "\(characters[i])UROptionsJSON")
                }
                if let encoded = try? JSONEncoder().encode(botResponseOptions[i]) {
                    UserDefaults.standard.set(encoded, forKey: "\(characters[i])BotOptionsJSON")
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
