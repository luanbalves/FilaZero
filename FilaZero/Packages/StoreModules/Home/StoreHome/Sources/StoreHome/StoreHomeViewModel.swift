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
    
    init(goToAddStore: @escaping () -> Void, storeServices: StoreServicesInterface) {
        self.goToAddStore = goToAddStore
        self.storeServices = storeServices
    }
    
    func didPressAddButton() {
        goToAddStore()
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
                #warning("Fazer alerta de sucesso e dar dismiss")
            } catch {
                print(error.localizedDescription)
                #warning("Fazer alerta de erro")
            }
        }
    }
    
}
