//
//  RegisterView.swift
//  FilaZero
//
//  Created by Luan Alves Barroso on 30/04/24.
//

import SwiftUI
import Components
import AuthServiceInterface

struct RegisterView: View {
    
    @FocusState private var focus: FocusableField?
    @ObservedObject var viewModel: RegisterViewModel
    
    var body: some View {
        VStack {
            
            Picker("Selecione o tipo de conta:", selection: $viewModel.selectedAccountType) {
                Text("Cliente").tag("Cliente")
                Text("Loja").tag("Loja")
            }
            .pickerStyle(SegmentedPickerStyle())
            
            ImageTextInputField(
                imageName: "person",
                placeholder: "Nome",
                text: $viewModel.fullname,
                isSecureField: false,
                focus: $focus,
                focusField: .fullname,
                submitLabel: .next,
                onSubmit: {
                    focus = .email
                },
                isMandatory: true
            )
            
            ImageTextInputField(
                imageName: "at",
                placeholder: "Email",
                text: $viewModel.email,
                isSecureField: false,
                focus: $focus,
                focusField: .email,
                submitLabel: .next,
                onSubmit: {
                    focus = .password
                },
                isMandatory: true
            )
            
            ImageTextInputField(
                imageName: "lock",
                placeholder: "Senha",
                text: $viewModel.password,
                isSecureField: true,
                focus: $focus,
                focusField: .password,
                submitLabel: .go,
                onSubmit: {
                    viewModel.signUp()
                },
                isMandatory: true
            )
            
            Button {
                viewModel.signUp()
            } label: {
                Text("Registrar-se")
            }
            .buttonStyle(BorderedProminentButtonStyle())
            #warning("Condicionais disabled")
        }
    }
}

#Preview {
    RegisterView( viewModel: .init(authService: AuthServiceMock()))
}
