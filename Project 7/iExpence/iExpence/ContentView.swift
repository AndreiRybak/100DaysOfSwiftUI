//
//  ContentView.swift
//  iExpence
//
//  Created by Andrei Rybak on 17.07.22.
//

import SwiftUI

struct ExpenseView: View {
    let expense: ExpenseItem

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(expense.name)
                    .font(.headline)
                Text(expense.type)
            }
            
            Spacer()
            
            HStack {
                Text(expense.amount, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                if expense.amount < 20 {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.green)
                } else if expense.amount < 100 {
                    Image(systemName: "exclamationmark.circle.fill")
                        .foregroundColor(.yellow)
                } else {
                    Image(systemName: "clear.fill")
                        .foregroundColor(.red)
                }
            }
        }
    }
}


struct ContentView: View {
    @StateObject var expenses = Expenses()
    
    @State private var showingAddExpense = false

    var body: some View {
        NavigationView {
            List {
                ForEach(expenses.items) { item in
                    ExpenseView(expense: item)
                }
                .onDelete(perform: removeItems)
            }
            .navigationTitle("iExpence")
            .toolbar {
                Button {
                    showingAddExpense = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showingAddExpense) {
                AddView(expenses: expenses)
            }
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
