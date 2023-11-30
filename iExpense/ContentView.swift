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
    
    @State private var sortOrder: [SortDescriptor] = [
        SortDescriptor(\Expense.name),
        SortDescriptor(\Expense.amount)
    ]
    
    @State private var filterExpense: String = ""
    
    @State private var path = [Expense]()
    
    @State private var originalExpenses: Expenses = Expenses()
    
    @State private var showingExpenseReport: Bool = false
    @State private var showingUserConfiguration: Bool = false
    @State private var showingAddExpense: Bool = false
    
    var body: some View {
        NavigationStack(path: $path) {
            ExpenseListView(sortOrder: sortOrder, filterExpense: filterExpense)
            .navigationTitle("iExpense")
            .toolbar {
                
                Menu("Sort", systemImage: "line.3.horizontal.decrease") {
                    Picker("Sort", selection: $sortOrder) {
                        Text("Sort by Name")
                            .tag([
                                SortDescriptor(\Expense.name),
                                SortDescriptor(\Expense.amount)
                            ])
                        
                        Text("Sort by Amount")
                            .tag([
                                SortDescriptor(\Expense.amount),
                                SortDescriptor(\Expense.name)
                            ])
                    }
                    
                    Picker("Filter", selection: $filterExpense) {
                        Text("Show All")
                            .tag("")
                        
                        Text("Show Personal Only")
                            .tag("Personal")
                        
                        Text("Show Business Only")
                            .tag("Business")
                    }
                }
                
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
}

#Preview {
    ContentView()
}
