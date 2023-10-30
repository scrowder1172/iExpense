//
//  sheetsExample.swift
//  iExpense
//
//  Created by SCOTT CROWDER on 10/30/23.
//

import SwiftUI

struct SecondView: View {
    let name: String
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        Text("Second View")
        Text("Hello, \(name)")
        Button {
            dismiss()
        } label: {
            Text("Dismiss This View")
        }
            .frame(width: 200, height: 30)
            .background(.blue)
            .foregroundStyle(.white)
            .clipShape(.rect(cornerRadius: 20))
    }
}

struct sheetsExample: View {
    
    @State private var showingSecondView: Bool = false
    
    @State private var yourName: String = ""
    var body: some View {
        VStack {
            Text("You need to provide your name and then click the button")
            TextField("Enter your name:", text: $yourName)
            Button{
                showingSecondView.toggle()
            } label: {
                Text("Show Second View")
            }
            .frame(width: 200, height: 30)
            .background(.blue)
            .foregroundStyle(.white)
            .clipShape(.rect(cornerRadius: 20))
            .sheet(isPresented: $showingSecondView) {
                SecondView(name: yourName)
            }
        }
        
    }
}

#Preview {
    sheetsExample()
}
