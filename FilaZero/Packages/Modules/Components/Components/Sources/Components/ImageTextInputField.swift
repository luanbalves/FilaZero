//
//  ImageTextInputField.swift
//
//
//  Created by Luan Alves Barroso on 18/05/24.
//

import Foundation
import SwiftUI


public enum FocusableField: Hashable {
    case fullname
    case email
    case password
}


public struct ImageTextInputField: View {
    let imageName: String
    let placeholder: String
    @Binding var text: String
    var isSecureField: Bool
    var focus: FocusState<FocusableField?>.Binding
    var focusField: FocusableField
    var submitLabel: SubmitLabel
    var onSubmit: () -> Void
    var isMandatory: Bool
    
    public init(imageName: String, placeholder: String, text: Binding<String>, isSecureField: Bool, focus: FocusState<FocusableField?>.Binding, focusField: FocusableField, submitLabel: SubmitLabel, onSubmit: @escaping () -> Void, isMandatory: Bool) {
        self.imageName = imageName
        self.placeholder = placeholder
        self._text = text
        self.isSecureField = isSecureField
        self.focus = focus
        self.focusField = focusField
        self.submitLabel = submitLabel
        self.onSubmit = onSubmit
        self.isMandatory = isMandatory
    }
    
    public var body: some View {
        HStack {
            Image(systemName: imageName)
                .offset(y: 7)
            TextInputField(
                placeholder,
                text: $text,
                isSecureField: isSecureField
            )
            .autocorrectionDisabled()
            .focused(focus, equals: focusField)
            .textInputAutocapitalization(.never)
            .submitLabel(submitLabel)
            .onSubmit(onSubmit)
            .isMandatory(isMandatory)
        }
        .padding()
        .background(Divider().frame(width: UIScreen.main.bounds.width - 35), alignment: .bottom)
    }
}
