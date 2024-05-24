//
//  LoginView.swift
//  FilaZero
//
//  Created by Luan Alves Barroso on 04/05/24.
//

import SwiftUI
import Components
import AuthServiceInterface

struct LoginView: View {
    @ObservedObject var viewModel: LoginViewModel
    @FocusState private var focus: FocusableField?
    
    var body: some View {
        VStack {
            
            Picker("Selecione o tipo de conta:", selection: $viewModel.selectedAccountType) {
                Text("Cliente").tag("Cliente")
                Text("Loja").tag("Loja")
            }
            .pickerStyle(SegmentedPickerStyle())
            
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
                isMandatory: false
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
                    viewModel.signIn()
                },
                isMandatory: false
            )
            
            Button {
                viewModel.signIn()
            } label: {
                Text("Entrar")
            }
            .buttonStyle(BorderedProminentButtonStyle())
            .padding(.top, 15)
            
            HStack(spacing: 3) {
                Text("Ainda não tem uma conta?")
                    .font(.footnote)
                Text("Registre-se!")
                    .bold()
                    .font(.footnote)
                    .onTapGesture {
                        viewModel.didPressRegisterButton()
                        print("Ir para registro")
                    }
            }
            .padding(.top)
        }
    }
}


#Preview {
    LoginView(viewModel: .init(
        registerButtonPressed: {  },
        authService: AuthServiceMock(),
        goToHome: {  }
    ))
}
