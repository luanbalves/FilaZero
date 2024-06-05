//
//  HomeViewModel.swift
//  FilaZero
//
//  Created by Luan Alves Barroso on 01/05/24.
//

import Foundation
import StoreServicesInterface
import CommonModels

final class HomeViewModel: ObservableObject {
    var storeServices: StoreServicesInterface
    @Published var stores: [Store?] = [nil]
    @Published var searchText = ""
    private let goToStore: (Store) -> Void
    private let goToCart: () -> Void
    
    init(storeServices: StoreServicesInterface, goToStore: @escaping (Store) -> Void, goToCart: @escaping () -> Void) {
        self.storeServices = storeServices
        self.goToStore = goToStore
        self.goToCart = goToCart
    }
    
    var filteredStores: [Store] {
        if searchText.isEmpty {
            return stores.compactMap { $0 }
        } else {
            return stores.compactMap { store in
                if let unwrappedStore = store, unwrappedStore.name.localizedCaseInsensitiveContains(searchText) {
                    return unwrappedStore
                } else {
                    return nil
                }
            }
        }
    }
    
    func fetchStores() {
        Task {
            do {
                stores = try await storeServices.fetchStoresClientSide()
            } catch {
                print(error.localizedDescription)
                #warning("Fazer alerta erro")
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
    
    func didPressAtStore(_ selectedStore: Store) {
        goToStore(selectedStore)
    }
    
    func didPressCart() {
        goToCart()
    }
}

final class CartViewModel: ObservableObject {
    @Published var cartManager: CartManager
    
    init(cartManager: CartManager) {
        self.cartManager = cartManager
    }
}


final class CartManager: ObservableObject {
    @Published var cartItems: [Product] = []
    
    func addToCart(_ product: Product) {
        cartItems.append(product)
    }
    
    var cartItemCount: Int {
        cartItems.count
    }
    
    var totalItemCount: Int {
        cartItems.count
    }
    
    var totalPrice: Double {
        Double(cartItems.reduce(0) { $0 + $1.price })
    }
}

final class StoreViewModel: ObservableObject {
    var storeServices: StoreServicesInterface
    var selectedStore: Store
    @Published var cartManager: CartManager
    
    private let goToCart: () -> Void
    
    init(storeServices: StoreServicesInterface, selectedStore: Store, cartManager: CartManager, goToCart: @escaping () -> Void) {
        self.storeServices = storeServices
        self.selectedStore = selectedStore
        self.cartManager = cartManager
        self.goToCart = goToCart
    }
    
    func addToCart(_ product: Product) {
        cartManager.addToCart(product)
    }
    
    func didPressCart() {
        goToCart()
    }
}
