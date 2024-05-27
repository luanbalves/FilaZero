import Foundation
import SwiftUI
import PhotosUI
import CommonModels

public protocol StoreServicesInterface {
    var selectedImage: PhotosPickerItem? { get set }
    var postImage: Image? { get set }
    var uiImage: UIImage? { get }
    
    var stores: [Store] { get }
    
    var searchText: String { get set }
    
    var filteredStores: [Store] { get }
    
    func loadImage(fromItem item: PhotosPickerItem?) async
    
    func uploadStore(name: String, description: String) async throws
    
    
    func fetchStoresClientSide() async throws -> [Store?]
    
    func fetchStoresStoreSide() async throws -> Store?

}
