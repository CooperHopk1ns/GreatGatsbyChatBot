//
//  CharacterListView.swift
//  GatsbyBot
//
//  Created by Cooper Hopkins on 5/31/23.
//

import SwiftUI

struct CharacterListView: View {
    //Basic Variables
    
    //View Specific Variables
    let characters = ["Nick Carraway","James Gatz", "Jay Gatsby", "Daisy Buchanan", "Tom Buchanan", "Jordan Baker", "George Wilson", "Mr. Gatz", "Meyer Wolfsheim", "Myrtle Wilson", "Owl Eyes", "Klipspringer"]
    //Do seperate Jay Gatsby and James Gatz
    //Possibly add character icons
    
    //Functions
    func fetchCharacterTraits() {
        
        //Decode Character Traits/Personality
        
    }
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    //Switch to enumerated array, then push character along with index to character view, then decode character traits and use pushed index for traits
                    ForEach(characters, id: \.self) { character in
                        NavigationLink(character) {
                            CharacterView(character: character)
                        }
                    }
                }
            }
            .navigationTitle("Characters")
            .task {
                fetchCharacterTraits()
            }
        }
    }
}

struct CharacterListView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterListView()
    }
}
