//
//  ContentView.swift
//  iExpense
//
//  Created by SCOTT CROWDER on 10/30/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            UserPreferencesExample()
            Rectangle()
                .frame(width: .infinity, height: 1)
            CodeableExample()
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
