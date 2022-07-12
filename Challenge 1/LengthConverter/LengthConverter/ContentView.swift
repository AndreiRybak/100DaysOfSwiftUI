//
//  ContentView.swift
//  LengthConverter
//
//  Created by Andrei Rybak on 12.07.22.
//

import SwiftUI

struct ContentView: View {
    
    private let lengthUnits: [UnitLength] = [.meters, .kilometers, .feet, .yards, .miles]
    
    @State private var length = 0.0
    @State private var selectedInputUnit: UnitLength = .meters
    @State private var selectedOutputUnit: UnitLength = .meters
    
    @FocusState private var isLengthTextFieldFocused: Bool
    
    private var convertedLength: Double {
        return Measurement(value: length, unit: selectedInputUnit).converted(to: selectedOutputUnit).value
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Length", value: $length, format: .number)
                }
                .keyboardType(.decimalPad)
                .focused($isLengthTextFieldFocused)
                
                Section {
                    Picker("Select input unit", selection: $selectedInputUnit) {
                        ForEach(lengthUnits, id: \.self) {
                            Text("\($0.symbol)")
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("Select input unit")
                }

                Section {
                    Picker("Select output unit", selection: $selectedOutputUnit) {
                        ForEach(lengthUnits, id: \.self) {
                            Text("\($0.symbol)")
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("Select output unit")
                }

                Section {
                    Text(convertedLength, format: .number)
                } header: {
                    Text("Converted length from \(selectedInputUnit.symbol) to \(selectedOutputUnit.symbol)")
                }
            }
            .navigationTitle("Length Converter")
        }
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                Button("Done") {
                    isLengthTextFieldFocused = false
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
