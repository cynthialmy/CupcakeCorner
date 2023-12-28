//
//  Order.swift
//  CupcakeCorner
//
//  Created by Cynthia LI on 2023-12-19.
//

import Foundation

@Observable
class Order: Codable {
    
    enum CodingKeys: String, CodingKey {
        case _type = "type"
        case _quantity = "quantity"
        case _specialRequestEnabled = "specialRequestEnabled"
        case _extraFrosting = "extraFrosting"
        case _addSprinkles = "addSprinkles"
        case _name = "name"
        case _city = "city"
        case _streetAddress = "streetAddress"
        case _zip = "zip"
    }
    
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    
    var type = 0
    var quantity = 3
    
    var specialRequestEnabled = false {
        didSet {
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    var extraFrosting = false
    var addSprinkles = false
    
    var name = ""
    var streetAddress = ""
    var city = ""
    var zip = ""
    
    var hasValidAddress: Bool {
        if streetAddress.trimmingCharacters(in: .whitespaces).isEmpty{
            return false
        }
        if name.isEmpty || city.isEmpty || zip.isEmpty {
            return false
        }
        return true
    }
    
    var cost: Decimal {
        var cost = Decimal(quantity) * 2
        
        cost += (Decimal(type) / 2)
        
        if extraFrosting {
            cost += Decimal(quantity)
        }
        
        if addSprinkles {
            cost += Decimal(quantity) / 2
        }
        
        return cost
    }
    
    // save the order to UserDefaults
    func saveToUserDefaults() {
        if let encoded = try? JSONEncoder().encode(self) {
            UserDefaults.standard.set(encoded,forKey: "SavedOrder")
        }
    }
    
    // load order from UserDefaults
    static func loadFromUserDefaults() -> Order? {
        if let savedOrder = UserDefaults.standard.object(forKey: "SavedOrder") as? Data {
            if let decodedOrder = try? JSONDecoder().decode(Order.self, from: savedOrder) {
                return decodedOrder
            }
        }
        return nil
    }
}
