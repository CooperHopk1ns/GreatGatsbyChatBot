//
//  ContentView.swift
//  GatsbyBot
//
//  Created by Cooper Hopkins on 5/31/23.
//

import SwiftUI

struct ContentView: View {
    
    @State var welcomeCompleted = false
    @State var appDescriptionCompleted = false
    
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
        .task {
            //Character Order
            //["Nick Carraway","James Gatz", "Jay Gatsby", "Daisy Buchanan", "Tom Buchanan", "Jordan Baker", "George Wilson", "Mr. Gatz", "Meyer Wolfsheim", "Myrtle Wilson", "Owl Eyes", "Klipspringer"]
            let characterTraits : [[String]] = [["Narrator", "Reserved", "Observant", "Moderately Wealtyh"], ["Ambitious", "Persistent", "Idealistic", "Not Wealthy"], ["Hopeful", "Obsessive", "Socially Awkward", "Extremely Wealthy"], ["Passive", "Flighty", "Superficial", "Wealthy"], ["Arrogant", "Large", "Aggressive", "Wealthy"], ["Athletic", "Unemotional", "Independent", "Wealthy"], ["Desperate", "Obsessive", "Unassuming", "Poor"], ["Supportive", "Humble", "Optimistic", "Middle Class"], ["Mysterious", "Cautious", "Criminal", "Wealthy"], ["Ambitious", "Trapped", "Reckless", "Poor"], ["Eccentric", "Knowledgeable", "Curious", "Sarcastic"], ["Opportunistic", "Disloyal", "Superficial", "Moderately Wealthy"]]
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
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
