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

#Preview {
    HomeView(viewModel: .init(storeServices: StoreServiceMock()))
}

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
