//
//  CustomViews.swift
//  iExpense
//
//  Created by SCOTT CROWDER on 11/29/23.
//

import Foundation
import SwiftUI

struct HStackItem: View {
    // Formatted version of item entries
    let expenseItem: Expense
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
                Text(expenseItem.currency_amount)
                    .foregroundStyle(expenseItem.amount < lowAmount ? .blue : expenseItem.amount < highAmount ? .green : .red)
                Text(expenseItem.dateAdded.formatted(date: .numeric, time: .omitted))
            }
        }
        .accessibilityElement()
        .accessibilityLabel("\(expenseItem.name), \(expenseItem.currency_amount)")
        .accessibilityHint("\(expenseItem.type)")
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
