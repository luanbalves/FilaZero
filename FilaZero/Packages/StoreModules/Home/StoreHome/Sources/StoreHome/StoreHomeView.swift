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
                    .scaledToFit()
                
                Text(store.name)
                Text(store.description)
                
                ForEach(store.products) { product in
                    VStack {
                        Text(product.name)
                        Text(product.description)
                        Text(String(format: "%.2f", product.price))
                    }
                }
                
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
                viewModel.didPressAddProductButton()
            } label: {
                Text("Adicionar Produto")
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
    StoreHomeView(viewModel: .init(goToAddStore: {}, storeServices: StoreServiceMock(), goToAddProductStore: {}))
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

struct AddProductView: View {
    @ObservedObject var viewModel: StoreHomeViewModel

    var body: some View {
        Form {
            Section {
                TextField("Digite o nome do produto", text: $viewModel.productName)
            } header: {
                Text("Nome do produto")
            }
            
            Section {
                TextField("Digite a descrição do produto", text: $viewModel.productDescription)
            } header: {
                Text("Descrição do produto")
            }
            
            Section {
                TextField("Digite o preço do produto", value: $viewModel.productPrice, format: .number)
                    .keyboardType(.decimalPad)
            } header: {
                Text("Nome do produto")
            }
            
            Section {
                Button("Adicionar Produto") {
                    Task {
                        viewModel.addProduct()
                    }
                }
                .fontWeight(.bold)
                .frame(maxWidth: .infinity)
            }

        }
    }
}
