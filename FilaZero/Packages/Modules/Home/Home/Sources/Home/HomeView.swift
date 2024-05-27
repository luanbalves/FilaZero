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
            
            ForEach(viewModel.filteredStores) { store in
                KFImage(URL(string: store.selectedImage))
                    .resizable()
                    .scaledToFill()
                    .frame(width: 90, height: 90)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                Text(store.name)
                Text(store.description)
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
