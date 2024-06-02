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
    init(storeServices: StoreServicesInterface, goToStore: @escaping (Store) -> Void) {
        self.storeServices = storeServices
        self.goToStore = goToStore
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
}
