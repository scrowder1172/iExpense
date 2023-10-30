//
//  ContentView.swift
//  iExpense
//
//  Created by SCOTT CROWDER on 10/30/23.
//

import SwiftUI

struct ExpenseItem: Identifiable {
    // struct containing expense details
    let id: UUID = UUID()
    let name: String
    let type: String
    let amount: Double
}

@Observable
class Expenses {
    // class containing an array of expenses
    var items: [ExpenseItem] = [ExpenseItem]()
}

enum ExpenseType {
    case Personal, Business
}

struct ContentView: View {
    @State private var expenses: Expenses = Expenses()
    
    @State private var showingNewExpense: Bool = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(expenses.items) {item in
                    Text(item.name)
                }
                .onDelete(perform: removeItem)
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button("Add Example Item", systemImage: "plus") {
//                    let expense = ExpenseItem(name: "Test", type: "Personal", amount: 5)
//                    expenses.items.append(expense)
                    showingNewExpense = true
                }
            }
        }
        .sheet(isPresented: $showingNewExpense) {
            AddExpenseView(expenses: expenses)
        }
    }
    
    func removeItem(at offset: IndexSet) {
        expenses.items.remove(atOffsets: offset)
    }
}

#Preview {
    ContentView()
}
