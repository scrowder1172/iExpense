//
//  ContentView.swift
//  iExpense
//
//  Created by SCOTT CROWDER on 10/30/23.
//

import SwiftUI
import SwiftData

struct ExpenseThing: Identifiable, Codable {
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
    var items: [ExpenseThing] = [ExpenseThing]() {
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
            if let decodedItems = try? JSONDecoder().decode([ExpenseThing].self, from: savedItems) {
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
                Text(expenseItem.type.rawValue)
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
    @Environment(\.modelContext) var modelContext
    @Query(sort: \ExpenseItem.name) var expenses: [ExpenseItem]
    @State private var path = [ExpenseItem]()
    
    @State private var originalExpenses: Expenses = Expenses()
    
    @State private var showingExpenseReport: Bool = false
    @State private var showingUserConfiguration: Bool = false
    @State private var showingAddExpense: Bool = false
    
    var body: some View {
        NavigationStack(path: $path) {
            List {
                Section("Personal") {
                    ForEach(expenses) { expense in
                        if expense.type == .personal {
                            HStackItem(expenseItem: expense)
                        }
                    }
                    .onDelete(perform: removeExpenses)
                }
                
                Section("Business") {
                    ForEach(expenses) { expense in
                        if expense.type == .business {
                            HStackItem(expenseItem: expense)
                        }
                    }
                    .onDelete(perform: removeExpenses)
                }
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button {
                    showingAddExpense = true
                } label: {
                    Label("Add Item", systemImage: "plus")
                }
                
                Button("Configure", systemImage: "gearshape") {
                    showingUserConfiguration = true
                }
            }
            ExpenseButton(label: "View Report") {
                showingExpenseReport = true
            }
        }
        .sheet(isPresented: $showingAddExpense) {
            AddExpenseView()
        }
        .sheet(isPresented: $showingExpenseReport) {
            ExpenseReport(expenses: originalExpenses)
        }
        .sheet(isPresented: $showingUserConfiguration) {
            UserConfigurations()
        }
    }
    
    func removeExpenses(at offsets: IndexSet) {
        for offset in offsets {
            let expense = expenses[offset]
            modelContext.delete(expense)
        }
    }
}

#Preview {
    ContentView()
}
