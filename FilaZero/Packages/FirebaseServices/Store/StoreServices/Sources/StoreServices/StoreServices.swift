import Foundation
import FirebaseAuth
import SwiftUI
import PhotosUI
import CommonModels
import Utilities
import FirebaseFirestore
import StoreServicesInterface

public final class StoreServices: ObservableObject, StoreServicesInterface {
    @Published public var selectedImage: PhotosPickerItem? {
        didSet { Task { await loadImage(fromItem: selectedImage) } }
    }
    @Published public var postImage: Image?
    public var uiImage: UIImage?
    
    @Published public var stores = [Store]()
    
    @Published public var searchText = ""
    
    public var filteredStores: [Store] {
        if searchText.isEmpty {
            return stores
        } else {
            return stores.filter{ $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    public init() {
        Task { try await fetchStoresClientSide() }
    }
    
    public func loadImage(fromItem item: PhotosPickerItem?) async {
        guard let item = item else { return }
        guard let data = try? await item.loadTransferable(type: Data.self) else { return }
        guard let uiImage = UIImage(data: data) else { return }
        self.uiImage = uiImage
        self.postImage = Image(uiImage: uiImage)
    }
    
    public func uploadStore(name: String, description: String) async throws {
        guard let uiImage = uiImage else { return }
        guard let userID = Auth.auth().currentUser?.uid else { return }
        
        let storeRef = Firestore.firestore().collection("stores").document()
        guard let imageUrl = try await ImageUploader.uploadImage(image: uiImage) else { return }
        let stores = Store(id: storeRef.documentID, name: name, description: description, selectedImage: imageUrl, userID: userID)
        guard let encodedStores = try? Firestore.Encoder().encode(stores) else { return }
        try await storeRef.setData(encodedStores)
    }
    
    
    public func fetchStoresClientSide() async throws {
        let snapshot = try await Firestore.firestore().collection("stores").getDocuments()
        self.stores = try snapshot.documents.compactMap({ try $0.data(as: Store.self ) })
    }
    
    public func fetchStoresStoreSide() async throws -> Store?{
        guard let userID = Auth.auth().currentUser?.uid else { return nil }
        let snapshot = try await Firestore.firestore().collection("stores").whereField("userID", isEqualTo: userID).getDocuments()
        return try snapshot.documents.compactMap({ try $0.data(as: Store.self)}).first
    }
}
