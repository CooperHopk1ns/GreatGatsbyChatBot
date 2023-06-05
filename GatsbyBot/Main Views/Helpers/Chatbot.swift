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
    
    var progress = -1
    //Functions
    func generateUserResponseOptions(selectedCharacter: String) -> [String] {
        //Decode Progress
        if let characterProgressData = UserDefaults.standard.data(forKey: "\(selectedCharacter)ProgressJSON") {
            let decodedCharacterProgressData = try? JSONDecoder().decode(Int.self, from: characterProgressData)
            progress = decodedCharacterProgressData ?? -1
        }
        progress += 1
        //Encode Progress
        if let encoded = try? JSONEncoder().encode(progress) {
            UserDefaults.standard.set(encoded, forKey: "\(selectedCharacter)ProgressJSON")
        }
        var options = [""]
        let userResponseOptions = [["positive:Hello?", "neutral:Who is this?", "negative:Hey there illegal bootlegger!"], ["Ye", "Yhu"]]
        //let botResponseOptions = [["positive:Hello there old sport, I’m Jay Gatsby", "neutral:Hello, I’m Mr. Gatsby", "negative:How preposterous! Who are you and what do you want?!"]]
        if (progress >= userResponseOptions.count) {
            progress = userResponseOptions.count-1
        }
        options = userResponseOptions[progress]
        return options
    }
    func generateResponse(selectedCharacter: String, selectedResponse: String) -> String {
        var like = 0.5
        if let characterLikeData = UserDefaults.standard.data(forKey: "\(selectedCharacter)LikeJSON") {
            let decodedCharacterLikeData = try? JSONDecoder().decode(Double.self, from: characterLikeData)
            like = decodedCharacterLikeData ?? 0.5
        }
        //Delete When Done Testing //
        let progress = 0
        //let userResponseOptions = [["positive:Hello?", "neutral:Who is this?", "negative:Hey there illegal bootlegger!"]]
        let botResponseOptions = [["positive:Hello there old sport, I’m Jay Gatsby", "neutral:Hello, I’m Mr. Gatsby", "negative:How preposterous! Who are you and what do you want?!"]]
        //
        var responseText = ""
        //Encode ResponseTotalJSON
        if let encoded = try? JSONEncoder().encode(botResponseOptions.count) {
            UserDefaults.standard.set(encoded, forKey: "\(selectedCharacter)ResponseTotalJSON")
        }
        //Decode options based on selected character
            
        //Determine how bot will respond & whether increases or decreases like
        if (selectedResponse.contains("positive:")) {
            for i in 0..<botResponseOptions[progress].count {
                if (botResponseOptions[progress][i].contains("positive:")) {
                    responseText = botResponseOptions[progress][i]
                    like += 0.1
                }
            }
        } else if (selectedResponse.contains("negative:")) {
            for i in 0..<botResponseOptions[progress].count {
                if (botResponseOptions[progress][i].contains("negative:")) {
                    responseText = botResponseOptions[progress][i]
                }
            }
        } else if (selectedResponse.contains("neutral:")) {
            for i in 0..<botResponseOptions[progress].count {
                if (botResponseOptions[progress][i].contains("neutral:")) {
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
        //Update chat progress
        
        //Return Bot Response
        return responseText
    }
}
