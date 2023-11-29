//
//  ExpenseListView.swift
//  iExpense
//
//  Created by SCOTT CROWDER on 11/29/23.
//

import SwiftUI
import SwiftData

struct ExpenseListView: View {
    @Environment(\.modelContext) var modelContext
    
    @Query var expenses: [ExpenseItem]
    
    init(sortOrder: [SortDescriptor<ExpenseItem>]) {
        _expenses = Query(sort: sortOrder)
    }
    
    var body: some View {
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
    }
    
    func removeExpenses(at offsets: IndexSet) {
        for offset in offsets {
            let expense = expenses[offset]
            modelContext.delete(expense)
        }
    }
}

#Preview {
    ExpenseListView(sortOrder: [SortDescriptor(\ExpenseItem.name)])
        .modelContainer(for: ExpenseItem.self)
}
