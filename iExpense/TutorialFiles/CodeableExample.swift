//
//  CodeableExample.swift
//  iExpense
//
//  Created by SCOTT CROWDER on 10/30/23.
//

import SwiftUI

struct AppUser: Codable {
    var firstName: String
    var lastName: String
}

struct CodeableExample: View {
    @State private var userData: AppUser = AppUser(firstName: "Taylor1", lastName: "Swift")
    @State private var userDataRead: AppUser = AppUser(firstName: "Simple", lastName: "Simon")
    
    var body: some View {
        VStack {
            
            HStack {
                VStack {
                    HStack {
                        Spacer()
                        Text("First Name: ")
                        TextField("", text: $userData.firstName)
                            .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
                    }
                    
                    HStack {
                        Spacer()
                        Text("Last Name: ")
                        TextField("", text: $userData.lastName)
                            .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
                        
                    }
                }
                HStack {
                    Button("Save User") {
                        let encoder: JSONEncoder = JSONEncoder()
                        
                        if let data: Data = try? encoder.encode(userData) {
                            UserDefaults.standard.set(data, forKey: "UserData")
                        }
                    }
                    .frame(width: 100, height: 30)
                    .background(.blue)
                    .foregroundStyle(.white)
                    .clipShape(.rect(cornerRadius: 20))
                    Spacer()
                }
            }
            .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
            
            HStack {
                Button("Read User") {
                    if let data: Data = UserDefaults.standard.data(forKey: "UserData") {
                        let decoder: JSONDecoder = JSONDecoder()
                        if let loadedUser = try? decoder.decode(AppUser.self, from: data) {
                            userDataRead = loadedUser
                        }
                    }
                }
                .frame(width: 100, height: 30)
                .background(.blue)
                .foregroundStyle(.white)
                .clipShape(.rect(cornerRadius: 20))
                
                VStack {
                    Text("First Name: \(userDataRead.firstName)")
                    Text("Last Name: \(userDataRead.lastName)")
                }
                
            }
            
        }
    }
}

#Preview {
    CodeableExample()
}
