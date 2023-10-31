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
            Text("Business Expenses: \(businessExpenses)")
            Text("Personal Expenses: \(personalExpenses)")
            ExpenseButton(label: "Close Report") {
                dismiss()
            }
            .offset(x: 0, y: 150)
            
        }
        .onAppear(perform: getExpenses)
    }
    
    func getExpenses() {
        businessExpenses = formatAsUSCurrency(expenses.calculateBusinessExpenses())
        personalExpenses = formatAsUSCurrency(expenses.calculatePersonalExpenses())
        
    }
    
    func formatAsUSCurrency(_ amount: Double) -> String {
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
