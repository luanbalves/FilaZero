//
//  RegisterView.swift
//  FilaZero
//
//  Created by Luan Alves Barroso on 30/04/24.
//

import SwiftUI
import Components

enum FocusableField: Hashable {
    case email
    case password
}

struct RegisterView: View {
    
    @FocusState private var focus: FocusableField?
    @ObservedObject var viewModel: RegisterViewModel
    
    var body: some View {
        HStack {
            Image(systemName: "at")
                .offset(y: 7)
            TextInputField(
                "Email",
                text: $viewModel.email,
                isSecureField: false
            )
            .autocorrectionDisabled()
            .focused($focus, equals: .email)
            .textInputAutocapitalization(.never)
            .submitLabel(.next)
            .onSubmit {
                self.focus = .password
            }
            .isMandatory()
        }
        .padding()
        .background(Divider().frame(width: UIScreen.main.bounds.width - 35), alignment: .bottom)
        
        HStack {
            Image(systemName: "lock")
                .offset(y: 7)
            TextInputField("Senha", text: $viewModel.password, isSecureField: true)
                .autocorrectionDisabled()
                .focused($focus, equals: .password)
                .textInputAutocapitalization(.never)
                .submitLabel(.go)
                .onSubmit {
//                    CreateAccount()
                }
                .isMandatory()
        }
        .padding()
        .background(Divider().frame(width: UIScreen.main.bounds.width - 35), alignment: .bottom)
    }
}

#Preview {
    RegisterView( viewModel: .init())
}