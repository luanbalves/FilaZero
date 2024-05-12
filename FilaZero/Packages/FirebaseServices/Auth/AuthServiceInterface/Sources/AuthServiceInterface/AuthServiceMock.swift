//
//  AuthServiceMock.swift
//
//
//  Created by Luan Alves Barroso on 05/05/24.
//

import Foundation
import CommonModels
import FirebaseAuth

public class AuthServiceMock: AuthServiceInterface {
    public init() {
        
    }
    
    public var userSession: FirebaseAuth.User?
    
    public var currentUser: CommonModels.User? = CommonModels.User.MOCK_USER
    
    public func signIn(withEmail email: String, password: String) async throws {
        self.currentUser = User.MOCK_USER
    }
    
    public func createUser(withEmail email: String, password: String, fullname: String) async throws {
        self.currentUser = User.MOCK_USER
    }
    
    public func signOut() {
        self.currentUser = nil
    }
    
    public func fetchUser() async {
        self.currentUser = User.MOCK_USER
    }
    
    
}
