//
//  StoreServiceMock.swift
//
//
//  Created by Luan Alves Barroso on 25/05/24.
//

import Foundation
import SwiftUI
import PhotosUI
import CommonModels

public class StoreServiceMock: StoreServicesInterface {

    public init() {
        
    }
    
    public var selectedImage: PhotosPickerItem?
    
    public var postImage: Image?
    
    public var uiImage: UIImage?
    
    public var stores: [CommonModels.Store] = [CommonModels.Store.MOCK_STORE]
    
    public var searchText: String = ""
    
    public var filteredStores: [CommonModels.Store] = []
    
    public func loadImage(fromItem item: PhotosPickerItem?) async {
        
    }
    
    public func uploadStore(name: String, description: String) async throws {
        
    }
    
    public func fetchStores() async throws {
        
    }
}
