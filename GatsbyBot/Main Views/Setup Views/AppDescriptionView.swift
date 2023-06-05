//
//  AppDescriptionView.swift
//  GatsbyBot
//
//  Created by Cooper Hopkins on 6/4/23.
//

import SwiftUI

struct AppDescriptionView: View {
    
    @Binding var complete : Bool
    
    var body: some View {
        VStack {
            Text("App Description")
                .font(.system(size: 30))
                .fontWeight(.bold)
            //Description
            Text("GatsbyBot\u{2122} is an interactive chat bot that allows you to talk with many of the characters from F. Scott Fitzgerald's hit book \"The Great Gatsby\". However there is the possiblity to fail, so do be careful with your responses.")
                .padding()
                .padding(.horizontal, 25)
                .multilineTextAlignment(.center)
            Text("All dialogue in this app is pre-generated and original.")
                .multilineTextAlignment(.center)
                .padding()
            //Finish Button
            Button("Continue") {
                complete = true
                //Encode
                if let encoded = try? JSONEncoder().encode(complete) {
                    UserDefaults.standard.set(encoded, forKey: "setupFinishedJSON")
                }
            }
            .padding(.vertical, 6)
            .padding(.horizontal, 50)
            .foregroundColor(.white)
            .background(Color.black)
            .cornerRadius(20)
            .overlay (
                RoundedRectangle(cornerRadius: 20)
                    .stroke(lineWidth: 2)
            )
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(LinearGradient(colors: [Color.blue.opacity(0.7), Color.yellow], startPoint: .top, endPoint: .bottom))
    }
}

struct AppDescriptionView_Previews: PreviewProvider {
    static var previews: some View {
        AppDescriptionView(complete: .constant(false))
    }
}
