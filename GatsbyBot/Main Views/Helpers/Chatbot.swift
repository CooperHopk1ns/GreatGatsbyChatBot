//
//  Chatbot.swift
//  GatsbyBot
//
//  Created by Cooper Hopkins on 6/1/23.
//

import Foundation

class Chatbot {
    //Variables
    let characters = ["Nick Carraway","James Gatz", "Jay Gatsby", "Daisy Buchanan", "Tom Buchanan", "Jordan Baker", "George Wilson", "Mr. Gatz", "Meyer Wolfsheim", "Myrtle Wilson", "Owl Eyes", "Klipspringer"]
    //Have wolfsheim responses and then determine in the bot whether or not it agrees
    //Functions
    func generateResponse(selectedCharacter: String, selectedResponse: String) -> String {
        var responseText = ""
        switch selectedCharacter {
        case "Nick Carraway":
            responseText = generateResponseCarraway(selectedResponse: selectedResponse)
        case "James Gatz":
            responseText = generateResponseJGatz(selectedResponse: selectedResponse)
        case "Jay Gatsby":
            responseText = generatResponseGatsby(selectedResponse: selectedResponse)
        case "Daisy Buchanan":
            responseText = generateResponseDaisy(selectedResponse: selectedResponse)
        case "Tom Buchanan":
            responseText = generateResponseTom(selectedResponse: selectedResponse)
        case "Jordan Baker":
            responseText = generateResponseJordan(selectedResponse: selectedResponse)
        case "George Wilson":
            responseText = generateResponseGeorge(selectedResponse: selectedResponse)
        case "Mr. Gatz":
            responseText = generateResponseMGatz(selectedResponse: selectedResponse)
        case "Meyer Wolfsheim":
            responseText = generateResponseWolfsheim(selectedResponse: selectedResponse)
        case "Myrtle Wilson":
            responseText = generateResponseMyrtle(selectedResponse: selectedResponse)
        case "Owl Eyes":
            responseText = generateResponseOwl(selectedResponse: selectedResponse)
        case "Klipspringer":
            responseText = generateResponseKlipspringer(selectedResponse: selectedResponse)
        default:
            responseText = "Error"
        }
        
        
        return responseText
    }
    //Specific User Chat Generation
    
    //Variables
    let responsesPos : [String] = []
    let responsesNeut : [String] = []
    let responsesNeg : [String] = []
    var progression = 0
    //Update progression based on interactions to use for index of responses.
    //Function
    //Nick Carraway
    func generateResponseCarraway(selectedResponse: String) -> String {
        //if selected response = correct position then pos, like++, etc.
        //Possibly have response be universal i.e. good response is always 1, then hardcode?
        var charResponseText = ""
        if (selectedResponse == "Good Response") {
            charResponseText = "Good Choice"
        } else {
            charResponseText = "Bad Choice"
        }
        return charResponseText
    }
    //James Gatz
    func generateResponseJGatz(selectedResponse: String) -> String {
        var charResponseText = ""
        if (selectedResponse == "Good Response") {
            charResponseText = "Good Choice"
        } else {
            charResponseText = "Bad Choice"
        }
        return charResponseText
    }
    //Jay Gatsby
    func generatResponseGatsby(selectedResponse: String) -> String {
        var charResponseText = ""
        //Iterate through response options array and choose if good or bad based on that, possibly just store in JSON arrays so only one array and not a bunch to call
        if (selectedResponse == "Good Response") {
            charResponseText = "Good Choice"
        } else {
            charResponseText = "Bad Choice"
        }
        return charResponseText
    }
    //Daisy Buchanan
    func generateResponseDaisy(selectedResponse: String) -> String {
        var charResponseText = ""
        if (selectedResponse == "Good Response") {
            charResponseText = "Good Choice"
        } else {
            charResponseText = "Bad Choice"
        }
        return charResponseText
    }
    //Tom Buchanan
    func generateResponseTom(selectedResponse: String) -> String {
        var charResponseText = ""
        if (selectedResponse == "Good Response") {
            charResponseText = "Good Choice"
        } else {
            charResponseText = "Bad Choice"
        }
        return charResponseText
    }
    //Jordan Baker
    func generateResponseJordan(selectedResponse: String) -> String {
        var charResponseText = ""
        if (selectedResponse == "Good Response") {
            charResponseText = "Good Choice"
        } else {
            charResponseText = "Bad Choice"
        }
        return charResponseText
    }
    //George Wilson
    func generateResponseGeorge(selectedResponse: String) -> String {
        var charResponseText = ""
        if (selectedResponse == "Good Response") {
            charResponseText = "Good Choice"
        } else {
            charResponseText = "Bad Choice"
        }
        return charResponseText
    }
    //Mr. Gatz
    func generateResponseMGatz(selectedResponse: String) -> String {
        var charResponseText = ""
        if (selectedResponse == "Good Response") {
            charResponseText = "Good Choice"
        } else {
            charResponseText = "Bad Choice"
        }
        return charResponseText
    }
    //Meyer Wolfsheim
    func generateResponseWolfsheim(selectedResponse: String) -> String {
        var charResponseText = ""
        if (selectedResponse == "Good Response") {
            charResponseText = "Good Choice"
        } else {
            charResponseText = "Bad Choice"
        }
        return charResponseText
    }
    //Myrtle Wilson
    func generateResponseMyrtle(selectedResponse: String) -> String {
        var charResponseText = ""
        if (selectedResponse == "Good Response") {
            charResponseText = "Good Choice"
        } else {
            charResponseText = "Bad Choice"
        }
        return charResponseText
    }
    //Owl Eyes
    func generateResponseOwl(selectedResponse: String) -> String {
        var charResponseText = ""
        if (selectedResponse == "Good Response") {
            charResponseText = "Good Choice"
        } else {
            charResponseText = "Bad Choice"
        }
        return charResponseText
    }
    //Klipspringer
    func generateResponseKlipspringer(selectedResponse: String) -> String {
        var charResponseText = ""
        if (selectedResponse == "Good Response") {
            charResponseText = "Good Choice"
        } else {
            charResponseText = "Bad Choice"
        }
        return charResponseText
    }
}
