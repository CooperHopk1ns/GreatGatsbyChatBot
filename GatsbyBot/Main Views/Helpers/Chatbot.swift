//
//  Chatbot.swift
//  GatsbyBot
//
//  Created by Cooper Hopkins on 6/1/23.
//

import Foundation

class Chatbot {
    //Create all dialogue in contentview and then encode it, later decoding here based on what is needed
    //Variables
    let characters = ["Nick Carraway","James Gatz", "Jay Gatsby", "Daisy Buchanan", "Tom Buchanan", "Jordan Baker", "George Wilson", "Mr. Gatz", "Meyer Wolfsheim", "Myrtle Wilson", "Owl Eyes", "Klipspringer"]
//    let testDialogueGatsby = [["positive:Hello?", "neutral:Who is this?", "negative:Hey there illegal bootlegger!"], ["positive:Hello!, I'm Username", "neutral:I'm Username", "negative:I'm Username, But You Should Already Know That"], ["positive:You have such a large house, how'd you afford it?", "neutral:How'd you get your wealth?", "negative:What illegal activities did a guy like you do to get all your money?"]]
//    let testDialogueBot = [["positive:Hello there old sport, I’m Jay Gatsby", "neutral:Hello, I’m Mr. Gatsby", "negative:How preposterous! Who are you and what do you want?!"], ["positive:Nice To Meet You!", "neutral:Well, hello", "negative:ok...and?"], ["positive:I had a desire to be rich from a young age and worked hard to get here", "neutral:I made some good financial decisions", "negative:I do not like this line of questioning"]]
    var progress = 0
    var username = ""
    var botResponseOptions : [[String]] = [[]]
    var userResponseOptions : [[String]] = [[]]
    var options = [""]
    //Functions
    //Decode Username
    func fetchUsername() {
        if let usernameData = UserDefaults.standard.data(forKey: "usernameJSON") {
            let decodedUsernameData = try? JSONDecoder().decode(String.self, from: usernameData)
            username = decodedUsernameData ?? "user"
        }
        print(username)
    }
    //Generate User Responses
    func generateUserResponseOptions(selectedCharacter: String) -> [String] {
        fetchUsername()
        print("Generating User Response Options")
        //Decode Progress
        if let characterProgressData = UserDefaults.standard.data(forKey: "\(selectedCharacter)ProgressJSON") {
            let decodedCharacterProgressData = try? JSONDecoder().decode(Int.self, from: characterProgressData)
            progress = decodedCharacterProgressData ?? 0
        }
        if (progress < 0) {
            progress = 0
            if let encoded = try? JSONEncoder().encode(progress) {
                UserDefaults.standard.set(encoded, forKey: "\(selectedCharacter)ProgressJSON")
            }
        }
        print("Progress", progress)
        //Decode User Response Options
        if let selectedCharacterUROptionsData = UserDefaults.standard.data(forKey: "\(selectedCharacter)UROptionsJSON") {
            let decodedCharacterUROptionsData = try? JSONDecoder().decode([[String]].self, from: selectedCharacterUROptionsData)
            userResponseOptions = decodedCharacterUROptionsData ?? [[]]
        }
        //let botResponseOptions = [["positive:Hello there old sport, I’m Jay Gatsby", "neutral:Hello, I’m Mr. Gatsby", "negative:How preposterous! Who are you and what do you want?!"]]
        if (progress >= userResponseOptions.count) {
            progress = userResponseOptions.count-1
        }
        options = userResponseOptions[progress]
        return options
    }
    func generateResponse(selectedCharacter: String, selectedResponse: String) -> String {
        
        fetchUsername()
        print("Generating Bot Response")
        if let botResponseData = UserDefaults.standard.data(forKey: "\(selectedCharacter)BotOptionsJSON") {
            let decodedBotResponseData = try? JSONDecoder().decode([[String]].self, from: botResponseData)
            print("asdljfas;ldkjfa")
            botResponseOptions = decodedBotResponseData ?? [[]]
        }
        var like = 0.5
        if let characterLikeData = UserDefaults.standard.data(forKey: "\(selectedCharacter)LikeJSON") {
            let decodedCharacterLikeData = try? JSONDecoder().decode(Double.self, from: characterLikeData)
            like = decodedCharacterLikeData ?? 0.5
        }
        //Decode Progress
        if let characterProgressData = UserDefaults.standard.data(forKey: "\(selectedCharacter)ProgressJSON") {
            let decodedCharacterProgressData = try? JSONDecoder().decode(Int.self, from: characterProgressData)
            progress = decodedCharacterProgressData ?? 0
        }
        //Encode Progress
        if let encoded = try? JSONEncoder().encode(progress) {
            UserDefaults.standard.set(encoded, forKey: "\(selectedCharacter)ProgressJSON")
        }
        var responseText = ""
        //Encode ResponseTotalJSON
        if let encoded = try? JSONEncoder().encode(botResponseOptions.count) {
            UserDefaults.standard.set(encoded, forKey: "\(selectedCharacter)ResponseTotalJSON")
        }
        //Determine how bot will respond & whether increases or decreases like
        if (selectedResponse.contains("positive:")) {
            for i in 0..<botResponseOptions[progress].count {
                if (botResponseOptions[progress][i].contains("positive:")) {
                    responseText = botResponseOptions[progress][i]
                    like += 0.1
                }
            }
        } else if (selectedResponse.contains("neutral:")) {
            for i in 0..<botResponseOptions[progress].count {
                if (botResponseOptions[progress][i].contains("neutral:")) {
                    responseText = botResponseOptions[progress][i]
                }
            }
        } else if (selectedResponse.contains("negative:")) {
            for i in 0..<botResponseOptions[progress].count {
                if (botResponseOptions[progress][i].contains("negative:")) {
                    responseText = botResponseOptions[progress][i]
                    like -= 0.1
                }
            }
        }
        //Update
        //Update character like
        if let encoded = try? JSONEncoder().encode(like) {
            UserDefaults.standard.set(encoded, forKey: "\(selectedCharacter)LikeJSON")
        }
        //Update Progress
        //Increment Progress
        progress += 1
        //Encode Progress
        if let encoded = try? JSONEncoder().encode(progress) {
            UserDefaults.standard.set(encoded, forKey: "\(selectedCharacter)ProgressJSON")
        }
        //Return Bot Response
        return responseText
    }
}
