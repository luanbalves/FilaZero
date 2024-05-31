//
//  StoreHomeViewModel.swift
//  FilaZero
//
//  Created by Luan Alves Barroso on 23/05/24.
//

import Foundation
import StoreServicesInterface
import CommonModels

final class StoreHomeViewModel: ObservableObject {
    private let goToAddStore: () -> Void
    @Published var storeName = ""
    @Published var description = ""
    @Published var selectedStore: Store? = nil
    var storeServices: StoreServicesInterface
    @Published var productName = ""
    @Published var productDescription = ""
    @Published var productPrice: Float = 0.0
    private let goToAddProductStore: () -> Void
    
    init(goToAddStore: @escaping () -> Void, storeServices: StoreServicesInterface, goToAddProductStore: @escaping () -> Void) {
        self.goToAddStore = goToAddStore
        self.storeServices = storeServices
        self.goToAddProductStore = goToAddProductStore
    }
    
    func didPressAddButton() {
        goToAddStore()
    }
    
    func didPressAddProductButton() {
        goToAddProductStore()
    }
    
    func saveStore() {
        Task {
            do {
                try await storeServices.uploadStore(name: storeName, description: description)
                #warning("Fazer alerta de sucesso e dar dismiss")
            } catch {
                print(error.localizedDescription)
                #warning("Fazer alerta de erro")
            }
        }
    }
    
    func fetchStore() {
        Task {
            do {
                selectedStore = try await storeServices.fetchStoresStoreSide()
                if let store = selectedStore {
                    fetchProducts(for: store.id)
                }
            } catch {
                print(error.localizedDescription)
                #warning("Fazer alerta de erro")
            }
        }
    }
    
    func addProduct() {
        Task {
            do {
                let productID = UUID().uuidString
                let product = Product(id: productID, name: productName, description: productDescription, price: productPrice, storeID: "")
                try await storeServices.addProductToStore(product: product)
                
                #warning("Fazer alerta de sucesso e dar dismiss")
            } catch {
                print(error.localizedDescription)
                #warning("Fazer alerta de erro")
            }
        }
        
    }
    
    func fetchProducts(for storeID: String) {
        Task {
            do {
                try await storeServices.fetchProducts(for: storeID)
            } catch {
                print(error.localizedDescription)
                #warning("Fazer alerta")
            }
        }
    }
    
}
