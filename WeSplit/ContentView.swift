//
//  ContentView.swift
//  WeSplit
//
//  Created by Maxim P on 17/02/2024.
// Подсчет суммы, которую должен заплатить каждый человек, в зависимости от общей стоимости, выбранного процента чаевых и количества человек

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool
    let localCurrency = Locale.current.currency?.identifier ?? "USD"
    
    let tipPercenteges = [10, 15, 20, 25, 0]
    
    var grandTotal: Double {
        let tipSelection = Double(tipPercentage)
        let tipValue = checkAmount / 100 * tipSelection
        return checkAmount + tipValue
    }
    
    var totalPerPerson: Double {
        grandTotal / Double(numberOfPeople + 2)
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section{
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                    .pickerStyle(.navigationLink)
                }
                
                Section("How much do you want to tip?") {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(tipPercenteges, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
//                Section("How much do you want to tip?") {
//                    Picker("Tip percentage", selection: $tipPercentage) {
//                        ForEach(0..<101) {
//                            Text($0, format: .percent)
//                        }
//                    }
//                  
//                }
                
                Section("Total Amount") {
                    Text(grandTotal, format: .currency(code: localCurrency))
                        .foregroundStyle(tipPercentage == 0 ? .red : .primary )
                }
                
                Section("Amount per person"){
                    Text(totalPerPerson, format: .currency(code: localCurrency))
                        .keyboardType(.decimalPad)
                }
            }
            .navigationTitle("WeSplit")
            .toolbar() {
                if amountIsFocused {
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}
#Preview {
    ContentView()
}
