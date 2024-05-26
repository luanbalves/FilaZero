//
//  StoreHomeView.swift
//  FilaZero
//
//  Created by Luan Alves Barroso on 23/05/24.
//

import SwiftUI
import StoreServicesInterface
import Kingfisher
import FirebaseAuth

struct StoreHomeView: View {
    @ObservedObject var viewModel: StoreHomeViewModel
    
    var body: some View {
        ScrollView {
            if let store = viewModel.selectedStore {
                KFImage(URL(string: store.selectedImage))
                    .resizable()
                    .scaledToFill()
                    .frame(width: 90, height: 90)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                
                Text(store.name)
                Text(store.description)
            } else {
                ProgressView("Carregando...")
                    .onAppear {
                        Task {
                            viewModel.fetchStore()
                        }
                    }
            }
            Button {
                viewModel.didPressAddButton()
            } label: {
                Image(systemName: "plus.circle")
            }
            Button {
                Task {
                    do {
                        try Auth.auth().signOut()
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            } label: {
                Text("Sair")
            }
        }
        .refreshable {
            Task {
                viewModel.fetchStore()
            }
        }
    }
}

#Preview {
    StoreHomeView(viewModel: .init(goToAddStore: {}, storeServices: StoreServiceMock()))
    //    AddStoreView(viewModel: .init(goToAddStore: {}, storeServices: StoreServiceMock()))
}

struct AddStoreView: View {
    @ObservedObject var viewModel: StoreHomeViewModel
    @State private var imagePickerPresented = false
    
    var body: some View {
        
        Form {
            Section {
                TextField("Digite o nome da loja", text: $viewModel.storeName)
            } header: {
                Text("Nome da loja")
            }
            
            Section {
                TextField("Digite a descrição", text: $viewModel.description)
            } header: {
                Text("Descrição da loja")
            }
            
            Section(header: Text("Imagem")) {
                
                Button(action: {
                    imagePickerPresented.toggle()
                }) {
                    HStack {
                        Image(systemName: "photo.on.rectangle")
                        Text("Selecionar Imagem")
                    }
                }
                .photosPicker(isPresented: $imagePickerPresented, selection: $viewModel.storeServices.selectedImage)
                
                if viewModel.storeServices.postImage != nil {
                    viewModel.storeServices.postImage?
                        .resizable()
                        .scaledToFit()
                        .frame(height: 200)
                        .cornerRadius(12)
                }
            }
            
            Section {
                Button("Salvar Loja") {
                    Task {
                        viewModel.saveStore()
                    }
                }
                .fontWeight(.bold)
                .frame(maxWidth: .infinity)
            }
        }
    }
}
