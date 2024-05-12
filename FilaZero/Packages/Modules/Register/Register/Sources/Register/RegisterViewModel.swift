//
//  RegisterViewModel.swift
//  FilaZero
//
//  Created by Luan Alves Barroso on 01/05/24.
//

import Foundation

final class RegisterViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
}
