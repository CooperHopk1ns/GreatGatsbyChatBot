//
//  ChatView.swift
//  GatsbyBot
//
//  Created by Cooper Hopkins on 5/31/23.
//

import SwiftUI

struct ChatView: View {
    //Basic Variables
    
    //View Specific Variables
    let characters = ["Nick Carraway","James Gatz", "Jay Gatsby", "Daisy Buchanan", "Tom Buchanan", "Jordan Baker", "George Wilson", "Mr. Gatz", "Meyer Wolfsheim", "Myrtle Wilson", "Owl Eyes", "Klipspringer"]
    @State var selectedCharacter = "Jay Gatsby"
    @State var uROptions : [String] = ["Good Response", "Bad Response"]//For Testing//Change Later//
    @State var characterLike = 100
    @State var botChatHistory : [String] = []
    @State var userChatHistory : [String] = []
    //Functions
    func fetchCharacters() {
        
        //Decode JSON of like here
    }
    //Get Chat History
    func fetchChatHistory(selectedChar: String) {
        //Decode
        //Chat Bot History
        if let chatBotHistoryData = UserDefaults.standard.data(forKey: "\(selectedChar)ChatHistoryJSON") {
           let decodedChatBotHistoryData = try? JSONDecoder().decode([String].self, from: chatBotHistoryData)
           botChatHistory = decodedChatBotHistoryData ?? []
       }
        //User History
        if let userHistoryData = UserDefaults.standard.data(forKey: "\(selectedChar)UserChatHistoryJSON") {
           let decodedUserHistoryData = try? JSONDecoder().decode([String].self, from: userHistoryData)
           userChatHistory = decodedUserHistoryData ?? []
       }
    }
    
    var body: some View {
        VStack {
            //Use Menu For Selector
            //Default to Gatsby on app launch, when selected save most recent and initialize with that character
            //Selector
            VStack {
                Menu("\(selectedCharacter)") {
                    ForEach(characters, id: \.self) { character in
                        Button("\(character)") {
                            selectedCharacter = character
                            fetchChatHistory(selectedChar: selectedCharacter)
                            print(selectedCharacter)
                        }
                    }
                }
                .fontWeight(.bold)
                .font(.system(size: 20))
                Text("\(characterLike)%")
                    .fontWeight(.bold)
                    .font(.system(size: 16))
            }
            .padding()
            VStack {
                //If bad response throw up thumbs down and put characterLike down.
                //If character like at or below 0% then bot will not interact.
                //Possibly have certain events such as if percent at or below 0 then you fail and die in a specific way
                //Possibly have random popup events that lead to interaction with the character
                //Chat Screen
                VStack {
                    ScrollView {
                        if (botChatHistory.count != 0 && userChatHistory.count != 0) {
                        //Response Text
                        VStack {
                            //Either do two separate for each loops or have one loop and get index of, then put user response, if user response amount not equal just add ... typing thing
                            ForEach(botChatHistory, id: \.self) { botResponse in
                                Text(botResponse)
                                    .padding()
                                    .frame(maxWidth: UIScreen.main.bounds.width/2-5, alignment: .leading)
                                    .multilineTextAlignment(.leading)
                                    .background(Color.indigo)
                                    .foregroundColor(Color.white)
                                    .cornerRadius(20)
                                    .overlay (
                                        RoundedRectangle(cornerRadius: 20)
                                            .stroke(lineWidth: 4)
                                    )
                                    .padding([.horizontal])
                                    .padding(.top, 3)
                                
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        //User Input
                        VStack {
                            ForEach(userChatHistory, id: \.self) { userResponse in
                                Text(userResponse)
                                    .padding()
                                    .frame(maxWidth: UIScreen.main.bounds.width/2-5, alignment: .leading)
                                    .multilineTextAlignment(.leading)
                                    .background(Color.blue)
                                    .foregroundColor(Color.white)
                                    .cornerRadius(20)
                                    .overlay (
                                        RoundedRectangle(cornerRadius: 20)
                                            .stroke(lineWidth: 4)
                                    )
                                    .padding([.horizontal])
                                    .padding(.top, 3)
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        } else {
                            Text("You have not spoken with this character yet.")
                                .padding(.top, 250)
                        }
                    }
                    .padding(.top, 20)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .overlay (
                        Rectangle()
                            .frame(height: 2)
                            .foregroundColor(Color.black)
                        , alignment: .bottom
                    )
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                //Response Options
                VStack {
                    HStack {
                        ForEach(Array(uROptions), id: \.self) { option in
                            Button(action: {
                                userChatHistory.append(option)
                                botChatHistory.append(Chatbot().generateResponse(selectedCharacter: selectedCharacter, selectedResponse: option))
                                print(botChatHistory)
                                print(userChatHistory.count)
                                print(botChatHistory.count)
                                //Encode
                                if let encoded = try? JSONEncoder().encode(userChatHistory) {
                                    UserDefaults.standard.set(encoded, forKey: "\(selectedCharacter)UserChatHistoryJSON")
                                    print("encoded")
                                }
                                if let encoded = try? JSONEncoder().encode(botChatHistory) {
                                    UserDefaults.standard.set(encoded, forKey: "\(selectedCharacter)ChatHistoryJSON")
                                }
                            }, label: {
                                Text("\(option)")
                                    .font(.system(size: 12))
                                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                            })
                            .frame(width: UIScreen.main.bounds.width/3, height: 50)
                            .buttonStyle(.borderedProminent)
                            .buttonBorderShape(.roundedRectangle(radius: 9))
                            .padding()

                        }
                    }
                }
                .frame(width: UIScreen.main.bounds.width)
            }
            //Possibly change to gradient or have it cover the entire screen
            //If cover entire screen set top to have an overlay with a background so it still stands out
            .background(Color(red: 192/255, green: 224/255, blue: 222/255))
        }
        .padding(.bottom, 1)
        .navigationTitle(selectedCharacter)
        .task {
            fetchCharacters()
            fetchChatHistory(selectedChar: selectedCharacter)
        }
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
    }
}
