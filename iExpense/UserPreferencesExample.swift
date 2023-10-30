//
//  UserPreferencesExample.swift
//  iExpense
//
//  Created by SCOTT CROWDER on 10/30/23.
//

import SwiftUI

struct UserPreferencesExample: View {
    @State private var tapCount: Int = UserDefaults.standard.integer(forKey: "Tap")
    @State private var username: String = UserDefaults.standard.string(forKey: "Username") ?? "user"
    @AppStorage("firstName") private var firstName = "firstName"

    var body: some View {
        VStack {
            
            Text("Welcome back, \(firstName)")
            Text("You've tapped the button:")
            Text("\(tapCount)")
            
            Button("Tap Me") {
                tapCount += 1
            }
            
            Form {
                HStack {
                    Text("Update your first name:")
                    TextField("", text: $firstName)
                }
                HStack {
                    Text("Update your username: ")
                    TextField("", text: $username)
                }
            }
            
            Button("Save Data") {
                UserDefaults.standard.set(tapCount, forKey: "Tap")
                UserDefaults.standard.set(username, forKey: "Username")
            }
        }
        
    }
}

#Preview {
    UserPreferencesExample()
}
