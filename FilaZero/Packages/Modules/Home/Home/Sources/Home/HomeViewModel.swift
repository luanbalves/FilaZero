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
    
    init(storeServices: StoreServicesInterface) {
        self.storeServices = storeServices
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
}
