//
//  ContentView.swift
//  iExpense
//
//  Created by SCOTT CROWDER on 10/30/23.
//

import SwiftUI

struct ExpenseItem {
    // struct containing expense details
    let name: String
    let type: String
    let amount: Double
}

@Observable
class Expenses {
    // class containing an array of expenses
    var items: [ExpenseItem] = [ExpenseItem]()
}

struct ContentView: View {
    var body: some View {
        VStack {
            
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
