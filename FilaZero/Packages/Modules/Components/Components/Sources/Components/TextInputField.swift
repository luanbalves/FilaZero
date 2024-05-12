//
//  TextInputField.swift
//  FilaZero
//
//  Created by Luan Alves Barroso on 30/04/24.
//

import SwiftUI

public struct TextInputField: View {
    private var title: String
    var isSecureField: Bool
    @Binding private var text: String
    @Environment(\.clearButtonHidden) var clearButtonHidden
    @Environment(\.isMandatory) var isMandatory
    @Environment(\.validationHandler) var validationHandler
    
    @Binding private var isValidBinding: Bool
    @State private var isValid: Bool = true {
        didSet {
            isValidBinding = isValid
        }
    }
    @State var validationMessage: String = ""
    
    fileprivate func validate(_ value: String) {
        if isMandatory {
            isValid = !value.isEmpty
            validationMessage = isValid ? "" : "Esse campo é obrigatório!"
        }
        if isValid {
            guard let validationHandler = self.validationHandler else { return }
            let validationResult = validationHandler(value)
            if case . failure(let error) = validationResult {
                isValid = false
                self.validationMessage = "\(error.localizedDescription)"
            } else if case .success(let isValid) = validationResult {
                self.isValid = isValid
                self.validationMessage = ""
            }
        }
    }
    
    public init(
        _ title: String,
        text: Binding<String>,
        isValid isValidBinding: Binding<Bool>? = nil,
        isSecureField: Bool
    ) {
        self.title = title
        self._text = text
        self._isValidBinding = isValidBinding ?? .constant(true)
        self.isSecureField = isSecureField
    }
    
    var clearButton: some View {
        HStack {
            if !clearButtonHidden {
                Spacer()
                Button(action: { text = "" }, label: {
                    Image(systemName: "multiply.circle.fill")
                        .foregroundStyle(Color(.systemGray))
                })
            } else {
                EmptyView()
            }
        }
    }
    
    public var body: some View {
        ZStack(alignment: .leading) {
            if !isValid {
                Text(validationMessage)
                    .foregroundStyle(.red)
                    .offset(y: -25)
                    .scaleEffect(0.8, anchor: .leading)
            }
            Text(title)
                .foregroundStyle(text.isEmpty ? Color(.placeholderText) : .accentColor)
                .offset(y: text.isEmpty ? 0 : -25)
                .scaleEffect(text.isEmpty ? 1 : 0.8)
            
            if isSecureField {
                SecureField("", text: $text)
                    .padding(.trailing, !clearButtonHidden ? 25 : 0)
                    .overlay(clearButton)
                    .onAppear {
                        validate(text)
                    }
                    .onChange(of: text) { value in
                        validate(value)
                    }
            } else {
                TextField("", text: $text)
                    .padding(.trailing, !clearButtonHidden ? 25 : 0)
                    .overlay(clearButton)
                    .onAppear {
                        validate(text)
                    }
                    .onChange(of: text) { value in
                        validate(value)
                    }
            }
            
        }
        .padding(.top, 15)
    }
}
extension ValidationError: LocalizedError {
    public var errorDescription: String? {
        return NSLocalizedString("\(message)", comment: "Erro na validação dos dados")
    }
}
extension View {
    public func clearButtonHidden(_ hidesClearButton: Bool = true) -> some View {
        environment(\.clearButtonHidden, hidesClearButton)
    }
    
    public func isMandatory(_ value: Bool = true) -> some View {
        environment(\.isMandatory, value)
    }
    
    func onValidate(validationHandler: @escaping(String) -> Result <Bool, ValidationError>) -> some View {
        environment(\.validationHandler, validationHandler)
    }
}

private struct TextInputFieldClearButtonHidden: EnvironmentKey {
    static var defaultValue: Bool = false
}

public struct ValidationError: Error {
    let message: String
    
    public init(message: String) {
        self.message = message
    }
}

extension EnvironmentValues {
    var clearButtonHidden: Bool {
        get { self[TextInputFieldClearButtonHidden.self] }
        set { self[TextInputFieldClearButtonHidden.self] = newValue }
    }
    
    var isMandatory: Bool {
        get { self[TextInputFieldMandatory.self] }
        set { self[TextInputFieldMandatory.self] = newValue }
    }
    
    var validationHandler: ((String) -> Result<Bool, ValidationError>)? {
        get { self[TextInputFieldValidationHandler.self] }
        set { self[TextInputFieldValidationHandler.self] = newValue }
    }
}

private struct TextInputFieldMandatory: EnvironmentKey {
    static var defaultValue: Bool = false
}

private struct TextInputFieldValidationHandler: EnvironmentKey {
    static var defaultValue: ((String) -> Result<Bool, ValidationError>)?
}

#Preview {
    TextInputField("Título", text: .constant("Texto"), isSecureField: false)
}
