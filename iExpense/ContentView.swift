//
//  ContentView.swift
//  iExpense
//
//  Created by SCOTT CROWDER on 10/30/23.
//

import SwiftUI
import SwiftData

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
            ExpenseReport()
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
