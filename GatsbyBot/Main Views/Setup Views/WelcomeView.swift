//
//  WelcomeView.swift
//  GatsbyBot
//
//  Created by Cooper Hopkins on 6/4/23.
//

import SwiftUI

struct WelcomeView: View {
    
    @State var newUsername = ""
    @Binding var complete : Bool
    
    //Functions
    func encodeUsername(user: String) {
        if let encoded = try? JSONEncoder().encode(user) {
            UserDefaults.standard.set(encoded, forKey: "usernameJSON")
        }
    }
    
    var body: some View {
        VStack {
            Text("Hello User!")
                .font(.system(size: 30))
                .fontWeight(.bold)
                .padding()
            Text("What should each bot call you?")
            TextField("Enter Your First Name", text: $newUsername)
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal)
                .padding(.bottom, 40)
                .multilineTextAlignment(.center)
            Button("Enter") {
                encodeUsername(user: newUsername)
                complete = true
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
        .background(LinearGradient(colors: [Color.yellow, Color.blue.opacity(0.7)], startPoint: .top, endPoint: .bottom))
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView(complete: .constant(false))
    }
}
