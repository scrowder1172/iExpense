//
//  AtStateWithClasses.swift
//  iExpense
//
//  Created by SCOTT CROWDER on 10/30/23.
//

import SwiftUI

struct User {
    var firstName: String = "Bilbo"
    var lastName: String = "Baggins"
}

@Observable
class ShierUser {
    var firstName: String = "Bilbo"
    var lastName: String = "Baggins"
}


struct AtStateWithClasses: View {
    @State private var bilbo = User()
    
    @State private var shierBilbo = ShierUser()
    
    var body: some View {
        VStack {
            Text("Your name is \(bilbo.firstName) \(bilbo.lastName)")
            
            TextField("First name", text: $bilbo.firstName)
            TextField("Last name", text: $bilbo.lastName)
        }
        .background(.cyan)
        VStack {
            Text("Your name is \(shierBilbo.firstName) \(shierBilbo.lastName)")
            
            TextField("First name", text: $shierBilbo.firstName)
            TextField("Last name", text: $shierBilbo.lastName)
        }
        .background(.green)
        
    }
}

#Preview {
    AtStateWithClasses()
}
