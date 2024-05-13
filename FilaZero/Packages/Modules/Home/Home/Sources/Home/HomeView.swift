//
//  HomeView.swift
//  FilaZero
//
//  Created by Luan Alves Barroso on 30/04/24.
//

import SwiftUI
import AuthServiceInterface
import FirebaseAuth

struct HomeView: View {
    var body: some View {
        Text("FilaZero")
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
}

#Preview {
    HomeView()
}
