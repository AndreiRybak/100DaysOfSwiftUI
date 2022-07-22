//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by Andrei Rybak on 21.07.22.
//

import SwiftUI

struct AddressView: View {
    @StateObject var cupcakeOrder: CupcakeOrder
    
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $cupcakeOrder.order.name)
                TextField("Streed address", text: $cupcakeOrder.order.streetAddress)
                TextField("City", text: $cupcakeOrder.order.city)
                TextField("Zip", text: $cupcakeOrder.order.zip)
            }

            Section {
                NavigationLink {
                    Checkoutview(cupcakeOrder: cupcakeOrder)
                } label: {
                    Text("Check out")
                }
            }
            .disabled(cupcakeOrder.order.hasValidAddress == false)
        }
        .navigationTitle("Delivery details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        AddressView(cupcakeOrder: CupcakeOrder())
    }
}
