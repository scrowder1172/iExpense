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
        SortDescriptor(\ExpenseItem.name),
        SortDescriptor(\ExpenseItem.amount)
    ]
    
    @State private var path = [ExpenseItem]()
    
    @State private var originalExpenses: Expenses = Expenses()
    
    @State private var showingExpenseReport: Bool = false
    @State private var showingUserConfiguration: Bool = false
    @State private var showingAddExpense: Bool = false
    
    var body: some View {
        NavigationStack(path: $path) {
            ExpenseListView(sortOrder: sortOrder)
            .navigationTitle("iExpense")
            .toolbar {
                
                Menu("Sort", systemImage: "line.3.horizontal.decrease") {
                    Picker("Sort", selection: $sortOrder) {
                        Text("Sort by Name")
                            .tag([
                                SortDescriptor(\ExpenseItem.name),
                                SortDescriptor(\ExpenseItem.amount)
                            ])
                        
                        Text("Sort by Amount")
                            .tag([
                                SortDescriptor(\ExpenseItem.amount),
                                SortDescriptor(\ExpenseItem.name)
                            ])
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
