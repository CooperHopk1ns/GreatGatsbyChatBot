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
    let characters = ["Nick Carraway","Jay Gatsby", "Daisy Buchanan", "Tom Buchanan", "Meyer Wolfsheim"]
    @State var selectedCharacter = "Jay Gatsby"
    @State var uROptions : [String] = []//For Testing//Change Later//
    @State var selectedCharProgress : Double = 0
    @State var characterLike : Double = 0.5
    @State var botChatHistory : [String] = []
    @State var userChatHistory : [String] = []
    @State var chatCompleted = false
    @State var alertPresented = false
    //Functions
    //Get Progress
    func fetchCharProgress(selectedChar: String) {
        var progress : Int = 0
        var totalResponses : Int = 0
        var success = false
        //Decode Total Responses Given
        if let chatProgressData = UserDefaults.standard.data(forKey: "\(selectedChar)ProgressJSON") {
            let decodedChatProgressData = try? JSONDecoder().decode(Int.self, from: chatProgressData)
            progress = decodedChatProgressData ?? 0
        }
        print(progress)
        print("Progress then total responses")
        print(progress)
        //Decode Total Reponses
        if let chatTotalResponseData = UserDefaults.standard.data(forKey: "\(selectedChar)ResponseTotalJSON") {
            let decodedChatTotalResponseData = try? JSONDecoder().decode(Int.self, from: chatTotalResponseData)
            totalResponses = decodedChatTotalResponseData ?? 1
            if (totalResponses > 1) {
                success = true
            }
        }
        progress += 1
        print(totalResponses)
        print(success)
        print("--endadsfa---")
        //Calculate
        if (success == true) {
            selectedCharProgress = Double(progress)/Double(totalResponses)
            //Check If Progress "Complete", then use if/else to determine what to display
            if (progress >= totalResponses) {
                chatCompleted = true
            }
        } else {
            selectedCharProgress = 0
        }
        //Get Character Like
        if let characterLikeData = UserDefaults.standard.data(forKey: "\(selectedChar)LikeJSON") {
            let decodedCharacterLikeData = try? JSONDecoder().decode(Double.self, from: characterLikeData)
            characterLike = decodedCharacterLikeData ?? 0.5
        }
        print("-----")
        print(characterLike)
        print(selectedCharProgress)
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
    //Reset Chat Function
    func resetChat(selectedChar: String) {
        //Clear
        botChatHistory = []
        userChatHistory = []
        //Encode
        if let encoded = try? JSONEncoder().encode(botChatHistory) {
            UserDefaults.standard.set(encoded, forKey: "\(selectedChar)ChatHistoryJSON")
        }
        if let encoded = try? JSONEncoder().encode(userChatHistory) {
            UserDefaults.standard.set(encoded, forKey: "\(selectedChar)UserChatHistoryJSON")
        }
        if let encoded = try? JSONEncoder().encode(-1) {
            UserDefaults.standard.set(encoded, forKey: "\(selectedChar)ProgressJSON")
        }
        if let encoded = try? JSONEncoder().encode(0.5) {
            UserDefaults.standard.set(encoded, forKey: "\(selectedChar)LikeJSON")
        }
        print("Cleared All Chats")
        //Generate New Response Options
        uROptions = Chatbot().generateUserResponseOptions(selectedCharacter: selectedChar)
        chatCompleted = false
        selectedCharProgress = 0
        characterLike = 0.5
    }
    //Clear All Chats
    func resetAllChats() {
        //Clear Everything
        let emptyArray : [String] = []
        for i in 0..<characters.count {
            if let encoded = try? JSONEncoder().encode(emptyArray) {
                UserDefaults.standard.set(encoded, forKey: "\(characters[i])ChatHistoryJSON")
                UserDefaults.standard.set(encoded, forKey: "\(characters[i])UserChatHistoryJSON")
            }
            if let encoded = try? JSONEncoder().encode(0) {
                UserDefaults.standard.set(encoded, forKey: "\(characters[i])ProgressJSON")
            }
            if let encoded = try? JSONEncoder().encode(0.5) {
                UserDefaults.standard.set(encoded, forKey: "\(characters[i])LikeJSON")
            }
        }
        print("Cleared All Chats")
        //Visual Updates
        selectedCharProgress = 0
        userChatHistory = []
        botChatHistory = []
        //Generate New Response Options
        uROptions = Chatbot().generateUserResponseOptions(selectedCharacter: selectedCharacter)
        chatCompleted = false
    }
    //Clear All App Data
    func clearAllAppData() {
        resetAllChats()
        if let encoded = try? JSONEncoder().encode(false) {
            UserDefaults.standard.set(encoded, forKey: "setupFinishedJSON")
        }
        if let encoded = try? JSONEncoder().encode("") {
            UserDefaults.standard.set(encoded, forKey: "usernameJSON")
        }
    }
    
    var body: some View {
        VStack {
            //Use Menu For Selector
            //Default to Gatsby on app launch, when selected save most recent and initialize with that character
            //Selector
            VStack {
                HStack {
                    HStack {
                        Menu("\(selectedCharacter)") {
                            ForEach(characters, id: \.self) { character in
                                Button("\(character)") {
                                    chatCompleted = false
                                    selectedCharacter = character
                                    botChatHistory = []
                                    userChatHistory = []
                                    if (selectedCharProgress != 1 && selectedCharProgress > 0) {
                                        selectedCharProgress -= 1
                                    }
                                    fetchChatHistory(selectedChar: selectedCharacter)
                                    fetchCharProgress(selectedChar: selectedCharacter)
                                    uROptions = Chatbot().generateUserResponseOptions(selectedCharacter: selectedCharacter)
                                    print(selectedCharacter)
                                }
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .fontWeight(.bold)
                        .font(.system(size: 20))
                    }
                    .frame(width: UIScreen.main.bounds.width/1.35)
                    HStack {
                        //Probably Remove When Done Developing
                        Menu("\(Image(systemName: "ellipsis"))") {
                            Button("Reset Chat") {
                                resetChat(selectedChar: selectedCharacter)
                            }
                            Button("Clear App Data") {
                                clearAllAppData()
                            }
                        }
                    }
                }
                .foregroundColor(Color.blue)
                //Charcter Like
                ProgressView(value: characterLike)
                    .tint(Color.clear)
                    .background(LinearGradient(colors: [Color.red.opacity(1-characterLike), Color.green.opacity(characterLike)], startPoint: .leading, endPoint: .trailing))
                    .scaleEffect(x: 1, y: 2, anchor: .center)
                    .padding()
                //Chat Progression
                ProgressView(value: selectedCharProgress) { Text("Chat Progress") }
                    .progressViewStyle(.linear)
                    .padding([.horizontal])
            }
            .padding()
                if (characterLike > 0) {
                    VStack {
                        //If bad response throw up thumbs down and put characterLike down.
                        //If character like at or below 0% then bot will not interact.
                        //Possibly have certain events such as if percent at or below 0 then you fail and die in a specific way
                        //Possibly have random popup events that lead to interaction with the character
                        //Chat Screen
                        VStack {
                            ScrollViewReader { value in
                                ScrollView {
                                    if (botChatHistory.count != 0 && userChatHistory.count != 0) {
                                        ForEach(Array(botChatHistory.enumerated()), id: \.offset) {index, botResponse in
                                            //User Input
                                            VStack {
                                                Text(
                                                    userChatHistory[index]
                                                        .replacingOccurrences(of: "positive:", with: "")
                                                        .replacingOccurrences(of: "neutral:", with: "")
                                                        .replacingOccurrences(of: "negative:", with: "")
                                                )
                                                .minimumScaleFactor(0.5)
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
                                            .frame(maxWidth: .infinity, alignment: .trailing)
                                            //Response Text
                                            VStack {
                                                //Either do two separate for each loops or have one loop and get index of, then put user response, if user response amount not equal just add ... typing thing
                                                Text(botResponse.replacingOccurrences(of: "positive:", with: "").replacingOccurrences(of: "neutral:", with: "").replacingOccurrences(of: "negative:", with: ""))
                                                    .minimumScaleFactor(0.5)
                                                    .padding()
                                                    .frame(maxWidth: UIScreen.main.bounds.width/2-5, maxHeight: 125, alignment: .leading)
                                                    .multilineTextAlignment(.leading)
                                                    .background(Color.indigo)
                                                    .foregroundColor(Color.white)
                                                    .cornerRadius(20)
                                                    .overlay (
                                                        RoundedRectangle(cornerRadius: 20)
                                                            .stroke(lineWidth: 4)
                                                    )
                                                    .padding(.bottom, 10)
                                                    .padding([.horizontal])
                                                    .padding(.top, 3)
                                            }
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            
                                        }
//                                        .onChange(of: botChatHistory.count) {_ in
//                                            value.scrollTo(botChatHistory.count)
//                                            print(botChatHistory.count-1)
//                                            print("scrolling")
//                                        }
                                        if (chatCompleted == true) {
                                            VStack {
                                                Text("Congratulations!")
                                                    .fontWeight(.medium)
                                                Text("You have completed this character's conversation.")
                                                    .multilineTextAlignment(.center)
                                                Text("This character liked you \((characterLike*100).formatted())%.")
                                            }
                                            .padding()
                                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                                            .onChange(of: chatCompleted) {_ in
                                                value.scrollTo(botChatHistory.count-1)
                                                print("scrolling")
                                            }
                                            
                                        }
                                    } else {
                                        Text("You have not spoken with this character yet.")
                                            .padding(.top, 250)
                                    }
                                }
                                .padding(.vertical, 20)
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .overlay (
                                    Rectangle()
                                        .frame(height: 2)
                                        .foregroundColor(Color.black)
                                    , alignment: .bottom
                                )
                                .overlay (
                                    Rectangle()
                                        .frame(height: 2)
                                        .foregroundColor(Color.black)
                                    , alignment: .top
                                )
                            }
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        //Response Options
                        VStack {
                            if (chatCompleted == false) {
                                HStack {
                                    ForEach(Array(uROptions), id: \.self) { option in
                                        Button(action: {
                                            fetchCharProgress(selectedChar: selectedCharacter)
                                            userChatHistory.append(option)
                                            botChatHistory.append(Chatbot().generateResponse(selectedCharacter: selectedCharacter, selectedResponse: option))
                                            //Generate New Responses
                                            uROptions = Chatbot().generateUserResponseOptions(selectedCharacter: selectedCharacter)
                                            if (chatCompleted == true) {
                                                uROptions = []
                                            }
                                            print(uROptions)
                                            //Encode
                                            if let encoded = try? JSONEncoder().encode(userChatHistory) {
                                                UserDefaults.standard.set(encoded, forKey: "\(selectedCharacter)UserChatHistoryJSON")
                                                print("encoded")
                                            }
                                            if let encoded = try? JSONEncoder().encode(botChatHistory) {
                                                UserDefaults.standard.set(encoded, forKey: "\(selectedCharacter)ChatHistoryJSON")
                                            }
                                            //Get Character Like
                                            if let characterLikeData = UserDefaults.standard.data(forKey: "\(selectedCharacter)LikeJSON") {
                                                let decodedCharacterLikeData = try? JSONDecoder().decode(Double.self, from: characterLikeData)
                                                characterLike = decodedCharacterLikeData ?? 0.5
                                            }
                                            print("Character LIKEasdjkflasldkfja \(characterLike)")
                                        }, label: {
                                            //Filter out text value and then display
                                            Text("\(option.replacingOccurrences(of: "positive:", with: "").replacingOccurrences(of: "neutral:", with: "").replacingOccurrences(of: "negative:", with: ""))")
                                                .font(.system(size: 15))
                                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                                .minimumScaleFactor(0.5)
                                        })
                                        .frame(maxHeight: 70)
                                        .buttonStyle(.borderedProminent)
                                        .buttonBorderShape(.roundedRectangle(radius: 9))
                                        .padding(.vertical)
                                        
                                    }
                                }
                            }
                        }
                        .padding(.horizontal)
                        .frame(width: UIScreen.main.bounds.width)
                    }
                } else {
                    VStack{
                        VStack {
                            Text("This character refuses to speak with you. Clicking the button below will allow you to try again, however all progress with all characters is reset. You can continue interacting with all characters except for those who no longer want to talk to you.")
                                .multilineTextAlignment(.center)
                                .padding()
                            Button("Try Again?") {
                                clearAllAppData()
                                alertPresented.toggle()
                            }
                            .alert(isPresented: $alertPresented) {
                                Alert(title: Text("Please Close The App And Re-Launch To Finish"))
                            }
                            .foregroundColor(Color.red)
                        }
                        .padding()
                        .frame(alignment: .center)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            //Possibly change to gradient or have it cover the entire screen
            //If cover entire screen set top to have an overlay with a background so it still stands out
        }
        .foregroundColor(Color.black)
        .background(Color(red: 192/255, green: 224/255, blue: 222/255))
        .padding(.bottom, 20)
        .navigationTitle(selectedCharacter)
        .task {
            chatCompleted = false
            fetchChatHistory(selectedChar: selectedCharacter)
            fetchCharProgress(selectedChar: selectedCharacter)
            uROptions = Chatbot().generateUserResponseOptions(selectedCharacter: "Jay Gatsby")
        }
        .onAppear {
            chatCompleted = false
            fetchChatHistory(selectedChar: selectedCharacter)
            fetchCharProgress(selectedChar: selectedCharacter)
        }
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
    }
}
