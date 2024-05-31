//
//  Product.swift
//
//
//  Created by Luan Alves Barroso on 29/05/24.
//

import Foundation

public struct Product: Identifiable, Codable {
    public var id: String
    public var name: String
    public var description: String
    public var price: Float
    public var storeID: String
    
    public init(id: String, name: String, description: String, price: Float, storeID: String) {
        self.id = id
        self.name = name
        self.description = description
        self.price = price
        self.storeID = storeID
    }
    
    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.description = try container.decode(String.self, forKey: .description)
        self.price = try container.decode(Float.self, forKey: .price)
        self.storeID = try container.decode(String.self, forKey: .storeID)
    }
    
}

public extension Product {
    static var MOCK_PRODUCT = Product(id: NSUUID().uuidString, name: "Produto", description: "Descrição do produto", price: 77.77, storeID: "ID da loja")
}

public extension Product {
    func toDictionary() -> [String: Any] {
        return [
            "id": id,
            "name": name,
            "description": description,
            "price": price,
            "storeID": storeID
        ]
    }
}
