//
//  LoginView.swift
//  FilaZero
//
//  Created by Luan Alves Barroso on 04/05/24.
//

import SwiftUI
import Components
import AuthServiceInterface

enum FocusableField: Hashable {
    case email
    case password
}

struct LoginView: View {
    @ObservedObject var viewModel: LoginViewModel
    @FocusState private var focus: FocusableField?
    
    var body: some View {
        VStack {
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
                        //                    Login()
                    }
            }
            .padding()
            .background(Divider().frame(width: UIScreen.main.bounds.width - 35), alignment: .bottom)
            
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
        authService: AuthServiceMock(), goToHome: {  }
    ))
}
