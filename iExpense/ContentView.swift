//
//  ContentView.swift
//  iExpense
//
//  Created by SCOTT CROWDER on 10/30/23.
//

import SwiftUI

struct ExpenseItem: Identifiable, Codable {
    // struct containing expense details
    // added Codable to allow for encoding and decoding of items
    var id: UUID = UUID()
    let name: String
    let type: String
    let amount: Double
}

@Observable
class Expenses {
    // class containing an array of expenses
    var items: [ExpenseItem] = [ExpenseItem]() {
        didSet {
            // save items as they are added
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    init() {
        // check if items exist and reload them otherwise create empty array
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
                items = decodedItems
                return
            }
        }
        
        items = []
    }
    
    func calculateBusinessExpenses() -> Double {
        var total: Double = 0.0
        for item in items {
            if item.type == "Business" {
                total += item.amount
            }
        }
        return total
    }
    
    func calculatePersonalExpenses() -> Double {
        var total: Double = 0.0
        for item in items {
            if item.type == "Personal" {
                total += item.amount
            }
        }
        return total
    }
}

enum ExpenseType {
    case Personal, Business
}

struct ContentView: View {
    @State private var expenses: Expenses = Expenses()
    
    @State private var showingNewExpense: Bool = false
    @State private var showingExpenseReport: Bool = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(expenses.items) {item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.name)
                                .font(.headline)
                            Text(item.type)
                                .font(.subheadline)
                        }
                        Spacer()
                        Text(item.amount, format: .currency(code: "USD"))
                    }
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
            Button("View Report") {
                showingExpenseReport = true
            }
            .frame(width: 200, height: 30)
            .background(.blue)
            .foregroundStyle(.white)
            .clipShape(.rect(cornerRadius: 20))
        }
        .sheet(isPresented: $showingNewExpense) {
            AddExpenseView(expenses: expenses)
        }
        .sheet(isPresented: $showingExpenseReport) {
            ExpenseReport(expenses: expenses)
        }
    }
    
    func removeItem(at offset: IndexSet) {
        expenses.items.remove(atOffsets: offset)
    }
}

#Preview {
    ContentView()
}
