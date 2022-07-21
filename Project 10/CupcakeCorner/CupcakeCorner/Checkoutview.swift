//
//  Checkoutview.swift
//  CupcakeCorner
//
//  Created by Andrei Rybak on 21.07.22.
//

import SwiftUI

struct Checkoutview: View {
    @ObservedObject var order: Order
    
    @State private var confirmationTitle = ""
    @State private var confirmationMesage = ""
    @State private var showingConfirmation = false
    
    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string:"https://hws.dev/img/cupcakes@3x.jpg"), scale: 3) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 233)
                
                Text("Your total is \(order.cost, format: .currency(code: "USD"))")
                
                Button("Place order") {
                    Task {
                        await placeOrder()
                    }
                }
                .padding()
            }
        }
        .navigationTitle("Check out")
        .navigationBarTitleDisplayMode(.inline)
        .alert(confirmationTitle, isPresented: $showingConfirmation) {
            Button("Ok") { }
        } message: {
            Text(confirmationMesage)
        }
    }
    
    func placeOrder() async {
        guard let encodedOrder = try? JSONEncoder().encode(order) else {
            print("Failed to encode order")
            return
        }
        
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        do {
            let (data, _) = try await URLSession.shared.upload(for: request, from: encodedOrder)
            
            let decodedOrder = try JSONDecoder().decode(Order.self, from: data)
            confirmationTitle = "Thank you!"
            confirmationMesage = "Your order for \(decodedOrder.quantity)x \(Order.types[decodedOrder.type].lowercased()) cupcakes is on it's way!"
            showingConfirmation = true
        } catch {
            confirmationTitle = "Ooops!"
            confirmationMesage = "Something went worng. Try again!"
            showingConfirmation = true
        }
    }
}

struct Checkoutview_Previews: PreviewProvider {
    static var previews: some View {
        Checkoutview(order: Order())
    }
}
