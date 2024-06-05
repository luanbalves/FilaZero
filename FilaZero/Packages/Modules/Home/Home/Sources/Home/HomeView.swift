//
//  HomeView.swift
//  FilaZero
//
//  Created by Luan Alves Barroso on 30/04/24.
//

import SwiftUI
import AuthServiceInterface
import FirebaseAuth
import StoreServicesInterface
import Kingfisher
import CommonModels

struct HomeView: View {
    @ObservedObject var viewModel: HomeViewModel
    
    var body: some View {
        VStack {
            List {
                ForEach(viewModel.filteredStores) { store in
                    StoreRow(
                        storeName: store.name,
                        storeDescription: store.description,
                        storeImage: store.selectedImage
                    )
                    .onTapGesture {
                        viewModel.fetchProducts(for: store.id)
                        viewModel.didPressAtStore(store)
                    }
                }
            }
            .refreshable {
                viewModel.fetchStores()
            }
            Button {
                Task {
                    do {
                        try await Auth.auth().signOut()
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            } label: {
                Text("Sair")
            }
        }
        .searchable(text: $viewModel.searchText, prompt: "Pesquisar")
        .onAppear {
            Task {
                viewModel.fetchStores()
            }
        }
    }
}

//#Preview {
//    //    HomeView(viewModel: .init(storeServices: StoreServiceMock(), goToStore: { _ in  }))
//    StoreView(selectedStore: Store(id: "id", name: "Nome loja", description: "Descricao da loja", selectedImage: "https://firebasestorage.googleapis.com:443/v0/b/filazero-8ae3b.appspot.com/o/storeImages%2FD11AFFFD-ABF6-4DF4-B19E-826AFE363038?alt=media&token=981c1265-bb75-4ddb-b05e-4e411bbf1eff", userID: "13", products: [Product(id: "idProduto", name: "NomeProduto", description: "Descricao Produto", price: 77.77, storeID: "idLoja"), Product(id: "idProduto", name: "NomeProduto", description: "Descricao Produto", price: 77.77, storeID: "idLoja")]), viewModel: .init(storeServices: StoreServiceMock(), goToStore: {_ in }, goToCart: {}))
//}

struct StoreRow: View {
    
    var storeName: String
    var storeDescription: String
    var storeImage: String
    
    var body: some View {
        HStack(spacing: 16) {
            KFImage(URL(string: storeImage))
                .resizable()
                .scaledToFill()
                .frame(width: 70, height: 70)
                .clipShape(RoundedRectangle(cornerRadius: 12))
            
            VStack {
                Text(storeName)
                    .font(.title3)
                    .fontWeight(.bold)
                
                Text(storeDescription)
                    .font(.footnote)
                    .multilineTextAlignment(.leading)
                    .lineLimit(2)
                    .padding(.trailing, 8)
            }
        }
    }
}

struct StoreView: View {
    @ObservedObject var viewModel: StoreViewModel
    @EnvironmentObject var cartManager: CartManager

    var body: some View {
        ScrollView {
            KFImage(URL(string: viewModel.selectedStore.selectedImage))
                .resizable()
                .scaledToFit()
            
            ForEach(viewModel.selectedStore.products) { product in
                VStack(alignment: .leading) {
                    HStack {
                        Text(product.name)
                            .bold()
                        Spacer()
                        Text(String(format: "R$ %.2f", product.price))
                            .padding(.horizontal)
                            .fontWeight(.semibold)
                        Button {
                            viewModel.addToCart(product)
                        } label: {
                            Image(systemName: "cart.badge.plus")
                        }
                    }
                    Text(product.description)
                        .font(.footnote)
                }
                .padding()
                .background(Divider().frame(width: UIScreen.main.bounds.width - 35), alignment: .bottom)
            }
        }
        .ignoresSafeArea()
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    viewModel.didPressCart()
                } label: {
                    ZStack {
                        Image(systemName: "cart.fill")
                        if cartManager.cartItemCount > 0 {
                            Text("\(cartManager.cartItems.count)")
                                .font(.caption2)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding(5)
                                .background(Color.red)
                                .clipShape(Circle())
                                .offset(x: 10, y: -10)
                        }
                    }
                }
            }
        }
    }
}

struct CartView: View {
    @ObservedObject var viewModel: CartViewModel
    @EnvironmentObject var cartManager: CartManager

    var body: some View {
        List {
            ForEach(viewModel.cartManager.cartItems) { product in
                HStack {
                    Text(product.name)
                    Spacer()
                    Text("R$ \(product.price, specifier: "%.2f")")
                }
            }
        }
        .navigationTitle("Carrinho (\(viewModel.cartManager.totalItemCount))")
        .navigationBarTitleDisplayMode(.inline)
        VStack {
            Text("Carrinho (\(viewModel.cartManager.totalItemCount))")
            Text("Total: R$ \(viewModel.cartManager.totalPrice, specifier: "%.2f")")
                .font(.title2)
                .fontWeight(.bold)
            Button {
                print("Finalizar pedido e aparecer na aba pedidos")
            } label: {
                Text("Finalizar Pedido")
            }
            Spacer()
        }
        .padding()
    }
}
