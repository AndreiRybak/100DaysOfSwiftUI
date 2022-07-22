//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Andrei Rybak on 21.07.22.
//

import SwiftUI

struct ContentView: View {
    @StateObject var cupcakeOrder = CupcakeOrder()
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Select your cake type", selection: $cupcakeOrder.order.type) {
                        ForEach(Order.types.indices) {
                            Text(Order.types[$0])
                        }
                    }
                    
                    Stepper("Number of cakes \(cupcakeOrder.order.quantity)", value: $cupcakeOrder.order.quantity, in: 3...20)
                }
                
                Section {
                    Toggle("Any special requests?", isOn: $cupcakeOrder.order.specialRequestEnabled.animation())
                    
                    if cupcakeOrder.order.specialRequestEnabled {
                        Toggle("Add extra frosting", isOn: $cupcakeOrder.order.extraFrosting)
                        Toggle("Add extra sprinkles", isOn: $cupcakeOrder.order.addSprinkles)
                    }
                }
                
                Section {
                    NavigationLink {
                        AddressView(cupcakeOrder: cupcakeOrder)
                    } label: {
                        Text("Delivery details")
                    }
                }
            }
            .navigationTitle("Cupcake Corner")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
