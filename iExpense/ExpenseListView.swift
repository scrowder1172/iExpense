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
    
    @Query var expenses: [Expense]
    
    init(sortOrder: [SortDescriptor<Expense>], filterExpense: String = "") {
        _expenses = Query(
            filter: #Predicate<Expense> {expense in
                if filterExpense.isEmpty {
                    return true
                } else {
                    return expense.type == filterExpense
                }
            },
            sort: sortOrder
        )
    }
    
    var body: some View {
        List {
            if expenses.contains(where: {$0.type == ExpenseType.personal.rawValue}) {
                Section("Personal") {
                    ForEach(expenses) { expense in
                        if expense.type == ExpenseType.personal.rawValue {
                            HStackItem(expenseItem: expense)
                        }
                    }
                    .onDelete(perform: removeExpenses)
                }
            }
            
            if expenses.contains(where: {$0.type == ExpenseType.business.rawValue}) {
                Section("Business") {
                    ForEach(expenses) { expense in
                        if expense.type == ExpenseType.business.rawValue {
                            HStackItem(expenseItem: expense)
                        }
                    }
                    .onDelete(perform: removeExpenses)
                }
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
    ExpenseListView(sortOrder: [SortDescriptor(\Expense.name)], filterExpense: "")
        .modelContainer(for: Expense.self)
}
