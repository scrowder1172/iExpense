//
//  iExpenseApp.swift
//  iExpense
//
//  Created by SCOTT CROWDER on 10/30/23.
//

import SwiftUI
import SwiftData

@main
struct iExpenseApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: ExpenseItem.self)
    }
}
