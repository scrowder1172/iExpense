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
    var dateAdded: Date = Date()
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

struct HStackItem: View {
    // Formatted version of item entries
    let expenseItem: ExpenseItem
    let lowAmount: Double = UserDefaults.standard.double(forKey: "lowAmount") == 0 ? 10 : UserDefaults.standard.double(forKey: "lowAmount")
    let highAmount: Double = UserDefaults.standard.double(forKey: "highAmount") == 0 ? 100 : UserDefaults.standard.double(forKey: "highAmount")
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(expenseItem.name)
                    .font(.headline)
                Text(expenseItem.type)
                    .font(.subheadline)
            }
            Spacer()
            VStack(alignment: .trailing) {
                Text(expenseItem.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                    .foregroundStyle(expenseItem.amount < lowAmount ? .blue : expenseItem.amount < highAmount ? .green : .red)
                Text(expenseItem.dateAdded.formatted(date: .numeric, time: .omitted))
            }
            
        }
    }
}

struct ExpenseButton: View {
    // custom button with consistent formatting and ability to click anywhere on button
    let label: String
    let action: () -> Void
    var body: some View {
        Button {
            action()
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(.blue)
                
                Text(label)
                    .foregroundStyle(.white)
                    .bold()
            }
        }
        .frame(width: 200, height: 30)
    }
}

struct ContentView: View {
    @State private var expenses: Expenses = Expenses()
    
    @State private var showingNewExpense: Bool = false
    @State private var showingExpenseReport: Bool = false
    @State private var showingUserConfiguration: Bool = false
    
    var body: some View {
        NavigationStack {
            List {
                Section("Personal Expenses") {
                    ForEach(expenses.items) {item in
                        if item.type == "Personal" {
                            HStackItem(expenseItem: item)
                        }
                        
                    }
                    .onDelete(perform: removeItem)
                }
                
                Section("Business Expenses") {
                    ForEach(expenses.items) {item in
                        if item.type == "Business" {
                            HStackItem(expenseItem: item)
                        }
                        
                    }
                    .onDelete(perform: removeItem)
                }
                
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button("Add Item", systemImage: "plus") {
                    showingNewExpense = true
                }
                Button("Configure", systemImage: "gearshape") {
                    showingUserConfiguration = true
                }
            }
            ExpenseButton(label: "View Report") {
                showingExpenseReport = true
            }
        }
        .sheet(isPresented: $showingNewExpense) {
            AddExpenseView(expenses: expenses)
        }
        .sheet(isPresented: $showingExpenseReport) {
            ExpenseReport(expenses: expenses)
        }
        .sheet(isPresented: $showingUserConfiguration) {
            UserConfigurations()
        }
    }
    
    func removeItem(at offset: IndexSet) {
        expenses.items.remove(atOffsets: offset)
    }
}

#Preview {
    ContentView()
}
