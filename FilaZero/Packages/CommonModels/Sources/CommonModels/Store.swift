//
//  Store.swift
//
//
//  Created by Luan Alves Barroso on 25/05/24.
//

import Foundation

public struct Store: Identifiable, Codable {
    public var id: String
    public var name: String
    public var description: String
    public var selectedImage: String
    public var userID: String
    public var products: [Product]
    
    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.description = try container.decode(String.self, forKey: .description)
        self.selectedImage = try container.decode(String.self, forKey: .selectedImage)
        self.userID = try container.decode(String.self, forKey: .userID)
        self.products = try container.decode([Product].self, forKey: .products)
    }
    
    public init(id: String, name: String, description: String, selectedImage: String, userID: String, products: [Product]) {
        self.id = id
        self.name = name
        self.description = description
        self.selectedImage = selectedImage
        self.userID = userID
        self.products = products
    }
}

public extension Store {
    static var MOCK_STORE = Store(id: NSUUID().uuidString, name: "Loja", description: "Temos diversos produtos...", selectedImage: "imageString", userID: "passUserID", products: [Product(id: "idProduto", name: "NomeProduto", description: "Descrição do produto", price: 77.77, storeID: "id da loja")])
}
