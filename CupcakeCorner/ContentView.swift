//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Cynthia LI on 2023-12-14.
//

import SwiftUI
import CoreHaptics

struct ContentView: View {
    @State private var order = Order()
    
    init() {
            if let loadedOrder = Order.loadFromUserDefaults() {
                _order = State(initialValue: loadedOrder) //  interact with _order to set up the initial state.
            } else {
                _order = State(initialValue: Order())
            }
        }
    
    var body: some View {
        NavigationStack {
            Form {
                Section{
                    Picker("Select your cake type", selection: $order.type) {
                        ForEach(Order.types.indices, id: \.self) {
                            Text(Order.types[$0])
                        }
                    }
                    
                    Stepper("Number of cakes: \(order.quantity)", value: $order.quantity, in: 3...20)
                }
                
                Section {
                    Toggle("Any special requests?", isOn: $order.specialRequestEnabled)
                    
                    if order.specialRequestEnabled {
                        Toggle("Add extra frosting", isOn: $order.extraFrosting)
                        Toggle("Any special sprinkles", isOn: $order.addSprinkles)
                    }
                }
                
                Section {
                    NavigationLink("Delivery details") {
                        AddressView(order: order)
                    }
                }
            }
            .navigationTitle("Cupcake Corner")
        }
    }
}

#Preview {
    ContentView()
}
