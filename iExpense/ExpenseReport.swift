//
//  ExpenseReport.swift
//  iExpense
//
//  Created by SCOTT CROWDER on 10/31/23.
//

import SwiftUI

struct ExpenseReport: View {
    
    var expenses: Expenses
    @State private var businessExpenses: String = ""
    @State private var personalExpenses: String = ""
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            Text("Expense Report")
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/).bold().underline()
                .offset(x: 0, y: -150)
            Text("Personal Expenses: \(personalExpenses)")
            Text("Business Expenses: \(businessExpenses)")
            ExpenseButton(label: "Close Report") {
                dismiss()
            }
            .offset(x: 0, y: 150)
            
        }
        .onAppear(perform: getExpenses)
    }
    
    func getExpenses() {
        businessExpenses = formatAsCurrency(expenses.calculateBusinessExpenses())
        personalExpenses = formatAsCurrency(expenses.calculatePersonalExpenses())
        
    }
    
    func formatAsCurrency(_ amount: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = Locale.current.currency?.identifier ?? "USD"

        if let formattedAmount = formatter.string(from: NSNumber(value: amount)) {
            return formattedAmount
        } else {
            return "Error formatting amount"
        }
    }
}

#Preview {
    ExpenseReport(expenses: Expenses())
}
